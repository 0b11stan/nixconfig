{
  pkgs,
  fetchFromGitHub,
  ...
}:
derivation {
  name = "seclists";

  system = builtins.currentSystem;

  src = fetchFromGitHub {
    owner = "danielmiessler";
    repo = "SecLists";
    rev = "master";
    sha256 = "sha256-CCj662K1+CstJmFKeB+vbPomkxyErzY3mJcOrWs9cf4=";
  };

  builder = "${pkgs.bash}/bin/bash";
  args = [
    "-c"
    ''
      ${pkgs.coreutils}/bin/ln -s $src $out
    ''
  ];
}
