{pkgs, ...}: {
  home.packages = with pkgs; [
    wireshark-qt
    #bloodhound
    zap
    burpsuite
  ];
}
