{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nerdtree
      # TODO: package NoahTheDuke/vim-just
      vim-markdown
      {
        plugin = dracula-vim;
        config = "colorscheme dracula";
      }
      supertab
      {
        plugin = nvim-lspconfig;
        config = ''
          lua require 'lspconfig'.pylsp.setup{}
          lua require 'lspconfig'.rnix.setup{}
          lua require 'lspconfig'.rust_analyzer.setup{}
        '';
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
