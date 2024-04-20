{pkgs, ...}: {
  programs.pandoc = {
    enable = true;
    templates."eisvogel.latex" = ./eisvogel.tex;
  };
}
