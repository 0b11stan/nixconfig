{pkgs, ...}: {
  home.packages = with pkgs; [
    gobuster
    nmap
    wireshark-cli
    metasploit
    inetutils # for ftp
    thc-hydra
    arp-scan
    macchanger
    sipcalc
    hashcat
    python39Packages.impacket
    python39Packages.scapy
    certipy
    vim # for xxd
    ffuf
  ];
}
