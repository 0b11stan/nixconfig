{...}: {
  programs.git = {
    enable = true;
    userEmail = "tristan@tic.sh";
    userName = "Tristan Pinaudeau";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
