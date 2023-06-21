set syntax
set number
set expandtab
set tabstop=2
set shiftwidth=2
set colorcolumn=81
set cursorline
set nofoldenable

set nocompatible

syntax enable
filetype plugin on

" Terminal mode configuration
au TermOpen * set nonumber

" Autocomment 
" TODO : make it dependant to language
vmap " :s/^/#<CR>:nohlsearch<CR>

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

" TODO : split line at 80 chars
"nmap ; 80|gea<CR>

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
autocmd BufRead,BufNewFile *.nix set filetype=nix

" FMTs
" TODO : use https://github.com/dmerejkowsky/vim-ale#usage-linting instead ?
function Fmt(cmd)
  normal Mt
  execute a:cmd
  normal `t
endfunction
autocmd BufWritePre *.nix call Fmt('%!alejandra -q')
autocmd BufWritePre *.py call Fmt('%!autopep8 -')
autocmd BufWritePre *.rs call Fmt('%!rustfmt')
autocmd BufWritePre *.html call Fmt('%!html-beautify')

" Enable lsp's autocomplete
set omnifunc=v:lua.vim.lsp.omnifunc

" Command execution in markdown
autocmd BufEnter *.md noremap X yypV:'<,'>!bash<CR>
