{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      ansible-vim
      vim-nix
      vim-markdown
      rust-vim
      nvim-web-devicons
      {
        plugin = nvim-tree-lua;
        config = ''
          lua require 'nvim-tree'.setup()
        '';
      }
      # TODO : package https://github.com/nvim-neo-tree/neo-tree.nvim
      # TODO : package https://github.com/nvim-telescope/telescope.nvim
      supertab
      {
        plugin = nvim-lspconfig;
        config = ''
          lua require 'lspconfig'.pylsp.setup{}
          lua require 'lspconfig'.rnix.setup{}
          lua require 'lspconfig'.rust_analyzer.setup{}
        '';
      }
      {
        plugin = markdown-preview-nvim;
        config = "let g:mkp_browser = '${pkgs.qutebrowser}/bin/qutebrowser'";
      }
      {
        plugin = dracula-vim;
        config = "colorscheme dracula";
      }
    ];
    extraPython3Packages = ps: with ps; [rich];
    extraPackages = with pkgs; [
      ctags

      # nix
      rnix-lsp

      # rust
      cargo
      rustc
      rustfmt
      rust-analyzer

      # javascript
      nodePackages.js-beautify

      # python
      python39
      python39Packages.python-lsp-server
      python39Packages.autopep8
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
