{pkgs, ...}: {
  home.packages = with pkgs; [
    python39Packages.python-lsp-server
  ];

  programs.neovim = {
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nerdtree
      {
        plugin = nvim-lspconfig;
        config = "lua require 'lspconfig'.pylsp.setup{}";
      }
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
