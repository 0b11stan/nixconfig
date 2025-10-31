{
  enable = true;
  settings = {
    alias.lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    user.email = "tristan@tic.sh";
    user.name = "Tristan Auvinet Pinaudeau";
    init.defaultBranch = "main";
    pull.rebase = false;
    core.autocrlf = "input";
  };
}
