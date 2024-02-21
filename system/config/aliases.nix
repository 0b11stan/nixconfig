{
  ip = "ip --color --brief";
  watch = "watch --color";
  tree = "tree -C";
  archlinux = "podman run -it --network=host -v $PWD:/mnt docker.io/archlinux bash";
  debian = "podman run -it --network=host -v $PWD:/mnt docker.io/debian bash";
  ubuntu = "podman run -it --network=host -v $PWD:/mnt docker.io/ubuntu bash";
  kali = "podman run -it --network=host -v $PWD:/mnt docker.io/kalilinux/kali-rolling";
  nessus = ''
    sudo podman run --name nessus -p 8834:8834 --network host --privileged \
      --env "USERNAME=0b11stan" \
      --env "PASSWORD=$(pass capgemini/nessus|head -n1)" \
      --env "ACTIVATION_CODE=$(pass capgemini/nessus|head -n2|tail -n1)" \
      docker.io/tenable/nessus:latest-ubuntu
  '';
  search = ''
    grep --color \
      --binary-files=without-match \
      --exclude-dir=.git \
      --exclude-dir=venv \
      --recursive \
      --ignore-case \
  '';
  password = "head -c 15 /dev/urandom | base32";
  dush = "sudo du -sh .[!.]* * 2>/dev/null | sort -h";
  openports = "ss -ltn4 'src = 0.0.0.0'";
  mount = "sudo mount -o uid=$(id -u),gid=$(id -g)";
  lsblk = "lsblk -o name,size,ro,type,label,mountpoint";
  nas = "/home/tristan/sources/github.com/0b11stan/selfhost-nas/mount_cifs.sh";
  scan = "scanimage --device 'airscan:w0:EPSON XP-5100 Series' --format png --progress --output-file";
  mirror = "wl-mirror $(swaymsg -t get_outputs | jq -r '.[0].name')";
  mirror-zone = ''wl-mirror $(swaymsg -t get_outputs | jq -r '.[0].name') --region "$(slurp)"'';
}
