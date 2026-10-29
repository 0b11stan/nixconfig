{
  config,
  lib,
  pkgs,
  ...
}: let
  firefox = lib.getExe config.programs.firefox.finalPackage;
  qutebrowser = lib.getExe pkgs.qutebrowser;

  linkRouter = pkgs.writeShellScriptBin "link-router" ''
    url="$1"
    host="''${url#*://}"
    host="''${host%%[/?#]*}"
    host="''${host##*@}"
    host="''${host%%:*}"

    case "$host" in
      *energy-robotics.net|*energy-robotics.com|\
      *aws.amazon.com|*amazonaws.com|*awsapps.com|\
      *microsoft.com|*microsoftonline.com|*office.com|\
      *azure.com|*azure.net|*azurewebsites.net|\
      *atlassian.net|*atlassian.com)
        exec ${firefox} -P er --new-tab "$url" ;;
      youtube.com|*.youtube.com|youtu.be|\
      instagram.com|*.instagram.com|\
      reddit.com|*.reddit.com)
        exec ${firefox} -P private --new-tab "$url" ;;
      *)
        exec ${qutebrowser} "$url" ;;
    esac
  '';
in {
  home.packages = [linkRouter];

  xdg = {
    desktopEntries.link-router = {
      name = "Link Router";
      exec = "link-router %u";
      mimeType = ["x-scheme-handler/http" "x-scheme-handler/https"];
      noDisplay = true;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "link-router.desktop";
        "x-scheme-handler/https" = "link-router.desktop";
        "text/html" = "link-router.desktop";
      };
    };
  };
}
