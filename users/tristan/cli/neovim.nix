{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [vim-nix nerdtree];
    extraConfig = builtins.readFile ./init.vim;
  };
}
