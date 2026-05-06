{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      # render-markdown-nvim
      snacks-nvim
      # supertab # commented because it breaks copilot-lua, which is a replacement for copilot-vim, which is no longer maintained
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require('copilot').setup({
            copilot_node_command = '${pkgs.nodejs}/bin/node',
            suggestion = {
              auto_trigger = true,
              keymap = {
                accept = "<Tab>",
              },
            },
          })
        '';
      }
      # maybe I should try https://github.com/folke/sidekick.nvim instead of avante
      {
        # Requires to have the environment variable ANTHROPIC_API_KEY set to a
        # valid API key. You can look at ../aliases.nix to see how it is
        # provided. For a list of available models see :
        # curl -s https://api.anthropic.com/v1/models -H "x-api-key: $ANTHROPIC_API_KEY" -H "anthropic-version: 2023-06-01" | jq -r '.data[] | .id'
        plugin = avante-nvim;
        type = "lua";
        config = ''
          require('avante').setup({
            provider = "claude",
            providers = {
              claude = {
                model = "claude-sonnet-4-5-20250929",
                extra_request_body = {
                  temperature = 0.75,
                  max_tokens = 8000,
                },
              },
            },
            behaviour = {
              auto_suggestions = false,                  -- copilot.lua handles this already
              auto_apply_diff_after_generation = false,  -- always review diffs first
              minimize_diff = true,
            },
            mappings = {
              submit = {
                normal = "<CR>",
                insert = "<C-s>",
              },
            },
            windows = {
              position = "right",
              width = 35,
            },
          })
        '';
      }
      ansible-vim
      vim-nix
      vim-markdown
      vim-svelte
      vim-terraform
      rust-vim
      nvim-web-devicons
      kitty-scrollback-nvim
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = "require('nvim-tree').setup{}";
      }
      {
        plugin = markdown-preview-nvim;
        config = "let g:mkp_browser = '${pkgs.qutebrowser}/bin/qutebrowser'";
      }
      {
        plugin = dracula-vim;
        config = "colorscheme dracula";
      }
      #      {
      #        plugin = nvim-lspconfig;
      #        config = ''
      #          lua require 'lspconfig'.pylsp.setup{}
      #          lua require 'lspconfig'.rust_analyzer.setup{}
      #          lua require 'lspconfig'.gopls.setup{}
      #        '';
      #      }
    ];
    extraPython3Packages = ps: with ps; [rich];
    extraPackages = with pkgs; [
      # rust
      cargo
      rustc
      rustfmt
      rust-analyzer

      # javascript
      js-beautify

      # python
      python312
      python312Packages.python-lsp-server
      python312Packages.autopep8

      # go
      go
      gopls

      # for snacks plugins
      imagemagick
      mermaid-cli
      fd
      ripgrep
    ];
    extraLuaPackages = ps: [ps.magick];
    extraConfig = builtins.readFile ./init.vim;
    initLua = builtins.readFile ./init.lua;
  };
}
