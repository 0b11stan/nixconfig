{pkgs, ...}: {
  home.packages = with pkgs; [
    gobuster
    nmap
    wireshark-cli
    metasploit
  ];
}
