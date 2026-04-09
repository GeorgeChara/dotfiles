" PlugInstall
call plug#begin()
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'preservim/nerdtree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

lua << EOF
require('lualine').setup({
  options = {
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  }
})
EOF

" -----------------------------------------------
" NERDTree Basic Config (from community best practices)
" -----------------------------------------------

" 1) Toggle NERDTree with Ctrl+n
nnoremap <C-n> :NERDTreeToggle<CR>

" 2) Auto-open NERDTree when starting Neovim in a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") |
      \ NERDTree | wincmd p | endif

" 3) Keep tree visible after opening splits
let NERDTreeQuitOnOpen = 0

" 4) Open hidden files in the tree explorer
let NERDTreeShowHidden = 1

" 5) Optional: Show the directory of the current file in the tree
nnoremap <leader>n :NERDTreeFind<CR>

" Theme
colorscheme tokyonight

" Variables
set nu rnu
set scrolloff=10
set cc=80

