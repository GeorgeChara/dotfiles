" Encoding (required for vim-devicons — must be before plug#begin)
set encoding=UTF-8

call plug#begin()
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'preservim/nerdtree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
call plug#end()

lua << EOF
require('lualine').setup({
  options = {
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_c = { 'filename' },
    lualine_x = { function() return 'C-h: tree  \\x: close' end },
  },
})

local ok, bufferline = pcall(require, 'bufferline')
if ok then
  bufferline.setup({
    options = {
      mode = 'buffers',
      diagnostics = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = 'thin',
      always_show_bufferline = false,
      offsets = {{
        filetype = 'nerdtree',
        text = 'Explorer',
        highlight = 'Directory',
        separator = true,
      }},
    },
  })
end
EOF

" Theme
set termguicolors
colorscheme tokyonight

" Line numbers and scrolling
set mouse=a
set nu rnu
set scrolloff=10

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 0
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 30

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") |
      \ NERDTree | wincmd p | endif

" Close Vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggle NERDTree with Ctrl+h
nnoremap <C-h> :NERDTreeToggle<CR>

" Auto-reload files changed externally
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" vim-devicons — folder icons in NERDTree
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Buffer navigation (VS Code-style tabs)
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
