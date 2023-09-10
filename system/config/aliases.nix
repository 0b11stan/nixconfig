{
  ip = "ip --color --brief";
  watch = "watch --color";
  tree = "tree -C";
  archlinux = "podman run -it --network=host -v $PWD:/srv docker.io/archlinux bash";
  debian = "podman run -it --network=host -v $PWD:/srv docker.io/debian bash";
  ubuntu = "podman run -it --network=host -v $PWD:/srv docker.io/ubuntu bash";
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
}
