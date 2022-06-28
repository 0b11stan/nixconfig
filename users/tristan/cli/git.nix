{...}: {
  programs.git = {
    enable = true;
    userEmail = "tristan@tic.sh";
    userName = "Tristan Pinaudeau";
    aliases = {
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
