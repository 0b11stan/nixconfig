{pkgs, ...}: {
  home.sessionVariables.SECLISTS = pkgs.seclists;

  home.packages = with pkgs; [
    # misc
    metasploit
    thc-hydra
    inetutils # for ftp
    python39Packages.impacket
    wpscan
    #exegol

    # github ressources
    seclists

    # cryptography
    certipy
    openssl

    # steganographie
    exiftool
    stegseek

    # reverse
    ghidra
    binutils
    vim # for xxd

    # offline brute-force and dict
    john
    hashcat

    # web fuzzer
    gobuster
    ffuf

    # network
    nmap
    arp-scan
    sipcalc
    macchanger
    aircrack-ng
    python39Packages.scapy

    # DNS enumeration
    amass
    dnsrecon

    # AD exploitation (by ropnop)
    windapsearch
    kerbrute
  ];
}
