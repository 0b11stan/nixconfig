{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".gitconfig".text = ''
    [user]
      email = tristan@tic.sh
      name = Tristan Pinaudeau
    [init]
      defaultBranch = main
    [pull]
      rebase = false
  '';

  programs.neovim = {
  	enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [ vim-nix nerdtree ];
    extraConfig = ''
      set number
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set colorcolumn=81
      set cursorline

      set nocompatible

      syntax enable
      filetype plugin on

      " Terminal mode configuration
      au TermOpen * set nonumber

      " Autocomment 
      " TODO : make it dependant to language
      vmap " :s/^/#<CR>

      " Use M key to set marks
      noremap M m

      " Remap keys for usage with azerty
      noremap j h
      noremap k j
      noremap l k
      noremap m l

      " Leave terminal mode on escape
      tnoremap <Esc> <C-\><C-n>

      " Move in panels using CTRL
      " (following line is a fix : https://github.com/neovim/neovim/issues/18245)
      noremap <CR> <C-w>l
      noremap <C-l> <C-w>k
      noremap <C-k> <C-w>j
      noremap <C-j> <C-w>h

      " Remove search
      noremap h :nohlsearch<CR>

      " So we can use `:find ...` for fuzzyfind
      set path+=**

      " TODO : link it to the write command!
      command! MakeTags !ctags -R .

      " Highlight cursor line
      hi CursorLine   cterm=NONE ctermbg=238
      hi CursorColumn cterm=NONE ctermbg=238

      " Nixos syntax highlight
      au BufRead,BufNewFile *.nix set filetype=nix
    '';
  };
}
