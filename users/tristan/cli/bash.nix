{...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      cdx() { cd $1; ls -l; }; alias cd="cdx"
    '';
  };
}
