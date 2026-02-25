{pkgs}:
with pkgs; [
  alejandra
  android-tools
  (azure-cli.withExtensions [azure-cli-extensions.ssh])
  bat
  bemenu
  bindfs
  (burpsuite.override {proEdition = true;})
  cifs-utils
  detox
  discord
  dnsmasq
  dos2unix
  drawio
  envsubst
  evince
  # exegol
  exfat
  exiftool
  ffmpeg
  file
  freerdp
  gcc
  gimp
  gnumake
  htmlq
  htop
  iw
  jmtpfs
  jq
  keepassxc
  ksnip
  ldns # for dns utils
  libreoffice
  appimage-run
  man-pages
  mpv
  nfs-utils
  nixpkgs-fmt
  nmap
  notify-desktop
  ntfs3g
  obsidian
  libsigrok
  openssl
  openvpn
  opkssh
  OVMF
  p7zip
  pavucontrol
  pciutils
  prismlauncher # minecraft
  python3
  qemu
  pulseview
  rdfind # duplicate file finder
  shutter
  # signal-desktop
  sshpass
  ssm-session-manager-plugin
  tenv
  tigervnc
  tree
  unzip
  usbutils
  uv
  wireguard-tools
  wl-clipboard
  wl-mirror
  xdg-utils
  xxd
  zip
  zoxide
]
