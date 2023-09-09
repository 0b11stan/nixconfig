{pkgs, ...}: {
  home.packages = with pkgs; [
    wireshark-qt
    zap
    burpsuite
  ];
}
