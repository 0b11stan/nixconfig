{pkgs, ...}: {
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.wlrobs
  ];
}
