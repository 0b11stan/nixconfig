{
  ip = "ip --color --brief";
  watch = "watch --color";
  tree = "tree -C";
  ps = "ps -f --ppid 2 --pid 2 --deselect";

  # containers
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
  webgitopen = ''$BROWSER $(printf "$(git config --get remote.origin.url) $(git rev-parse --abbrev-ref HEAD)" | sed "s%ssh://git@\(.*\)[:][0-9]*\(.*\).git \(.*\)$%https://\1\2/-/tree/\3%")'';
  mediarename = ''
    ls | xargs -I {} sh -c 'mv -v {} $(exiftool -T -createdate {} | tr " " "_" | tr ":" "-").$(echo {} | rev | cut -d "." -f 1 | rev | tr "[:upper:]" "[:lower:]")'
  '';

  # docker aliases
  dcu = "docker compose up";
  dcub = "docker compose up --build";
  dcd = "docker compose down";
  dcdv = "docker compose down --volumes";
  dstopall = "docker stop `docker ps -a -q`";
  drmall = "docker rm `docker ps -a -q`";
  dgenocide = "dstopall && drmall";
  dce = "docker compose exec";
  dceme = "docker compose exec --user = 1000";
}
