{pkgs, ...}: {
  home.packages = with pkgs; [
    # nix
    rnix-lsp

    # rust
    cargo
    rustc
    rustfmt
    rust-analyzer

    # python
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
          lua require 'lspconfig'.rust_analyzer.setup{}
        '';
      }
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
