{pkgs, ...}: {
  # TODO : i should use the https://github.com/0b11stan/offsec-toolbox instead
  home.packages = with pkgs; [
    gobuster
    nmap
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
    openssl
    john
    aircrack-ng

    windapsearch
  ];
}
