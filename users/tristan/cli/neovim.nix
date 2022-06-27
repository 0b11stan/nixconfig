{pkgs, ...}: {
  home.packages = with pkgs; [
    rnix-lsp
    python39
    python39Packages.python-lsp-server
    python39Packages.autopep8
  ];

  programs.neovim = {
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nerdtree
      {
        plugin = nvim-lspconfig;
        config = ''
          lua require 'lspconfig'.pylsp.setup{}
          lua require 'lspconfig'.rnix.setup{}
        '';
      }
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
