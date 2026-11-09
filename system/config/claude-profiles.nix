# Multiple Claude Code instances (one per subscription / customer).
#
# The upstream `programs.claude-code` module is a singleton (it exports a
# global CLAUDE_CONFIG_DIR), so each profile here gets its own config dir and
# its own launcher instead. Profiles are declared from customer modules:
#
#   programs.claude-profiles.er = { command = "claude-k"; settings = { ... }; };
{
  config,
  lib,
  pkgs,
  ...
}: let
  json = pkgs.formats.json {};
  cfg = config.programs.claude-profiles;
in {
  options.programs.claude-profiles = lib.mkOption {
    default = {};
    description = "Claude Code profiles, each with its own CLAUDE_CONFIG_DIR and launcher.";
    type = lib.types.attrsOf (lib.types.submodule ({name, ...}: {
      options = {
        configDir = lib.mkOption {
          type = lib.types.str;
          default = ".claude/${name}";
          description = "Config directory, relative to $HOME.";
        };
        command = lib.mkOption {
          type = lib.types.str;
          default = "claude-${name}";
          description = "Name of the launcher put in PATH.";
        };
        settings = lib.mkOption {
          inherit (json) type;
          default = {};
          description = ''
            Merged into settings.json on activation. Nix-managed keys win,
            keys written by Claude at runtime are kept.
          '';
        };
      };
    }));
  };

  config = lib.mkIf (cfg != {}) {
    home.packages =
      [pkgs.claude-code]
      ++ lib.mapAttrsToList (_: p:
        pkgs.writeShellScriptBin p.command ''
          export CLAUDE_CONFIG_DIR="$HOME/${p.configDir}"
          exec ${lib.getExe pkgs.claude-code} "$@"
        '')
      cfg;

    home.activation.claudeProfiles = lib.hm.dag.entryAfter ["writeBoundary"] (
      lib.concatStrings (lib.mapAttrsToList (name: p: let
          static = json.generate "claude-${name}-settings.json" p.settings;
        in ''
          f="$HOME/${p.configDir}/settings.json"
          if [ -z "''${DRY_RUN:-}" ]; then
            mkdir -p "$(dirname "$f")"
            [ -s "$f" ] || echo '{}' > "$f"
            ${lib.getExe pkgs.jq} -s '.[0] * .[1]' "$f" ${static} > "$f.tmp"
            chmod 600 "$f.tmp"
            mv "$f.tmp" "$f"
          else
            echo "would merge ${static} into $f"
          fi
        '')
        cfg)
    );
  };
}
