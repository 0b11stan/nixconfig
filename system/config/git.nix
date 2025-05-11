{
  enable = true;
  userEmail = "tristan@tic.sh";
  userName = "Tristan Auvinet Pinaudeau";
  aliases = {
    lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
  };
  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = false;
    core.autocrlf = "input";
  };
}
