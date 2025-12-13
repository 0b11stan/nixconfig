{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      ansible-vim
      vim-nix
      vim-markdown
      vim-svelte
      vim-terraform
      rust-vim
      nvim-web-devicons
      supertab
      image-nvim
      {
        plugin = nvim-tree-lua;
        config = "lua require 'nvim-tree'.setup{}";
      }
      {
        plugin = markdown-preview-nvim;
        config = "let g:mkp_browser = '${pkgs.qutebrowser}/bin/qutebrowser'";
      }
      {
        plugin = dracula-vim;
        config = "colorscheme dracula";
      }
      # TODO : package https://github.com/nvim-neo-tree/neo-tree.nvim
      # TODO : package https://github.com/nvim-telescope/telescope.nvim
      #      {
      #        plugin = nvim-lspconfig;
      #        config = ''
      #          lua require 'lspconfig'.pylsp.setup{}
      #          lua require 'lspconfig'.rust_analyzer.setup{}
      #          lua require 'lspconfig'.gopls.setup{}
      #        '';
      #      }
    ];
    extraPython3Packages = ps: with ps; [rich];
    extraPackages = with pkgs; [
      # rust
      cargo
      rustc
      rustfmt
      rust-analyzer

      # javascript
      nodePackages.js-beautify

      # python
      python312
      python312Packages.python-lsp-server
      python312Packages.autopep8

      # go
      go
      gopls

      # for image-nvim
      imagemagick
    ];
    extraLuaPackages = ps: [ps.magick];
    extraConfig = builtins.readFile ./init.vim;
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
