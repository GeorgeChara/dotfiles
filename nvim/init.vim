" Disable netrw (nvim-tree owns directory handling)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Encoding
set encoding=UTF-8

call plug#begin()
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
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
        filetype = 'NvimTree',
        text = 'Explorer',
        highlight = 'Directory',
        separator = true,
      }},
    },
  })
end

local tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if tree_ok then
  nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_directories = { enable = true, auto_open = true },
    view = { width = 30, side = 'left' },
    renderer = {
      group_empty = true,
      indent_markers = { enable = true },
      icons = { show = { folder_arrow = true } },
    },
    filters = { dotfiles = false, custom = { '^.git$' } },
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = { enable = false },
      },
    },
    update_focused_file = { enable = true, update_root = false },
  })
end

-- Hide the terminal cursor while focus is on an NvimTree buffer.
-- Uses DECTCEM escape sequences; guicursor-based tricks are global and unreliable.
local write = vim.api.nvim_ui_send or function(s) io.stdout:write(s) end
local hide_cursor = function() write('\27[?25l') end
local show_cursor = function() write('\27[?25h') end

local function is_tree(buf)
  local ok, api = pcall(require, 'nvim-tree.api')
  return ok and api.tree.is_tree_buf(buf)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
  callback = function(ev)
    if is_tree(ev.buf) then hide_cursor() else show_cursor() end
  end,
})
vim.api.nvim_create_autocmd('CmdlineEnter', { callback = show_cursor })
vim.api.nvim_create_autocmd('CmdlineLeave', {
  callback = function()
    if is_tree(vim.api.nvim_get_current_buf()) then hide_cursor() end
  end,
})
EOF

" Theme
set termguicolors
colorscheme tokyonight

" Line numbers and scrolling
set mouse=a
set nu rnu
set scrolloff=10

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-h> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Auto-open tree on argless startup
autocmd VimEnter * if argc() == 0 | NvimTreeOpen | wincmd p | endif

" Auto-reload files changed externally
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" Buffer navigation (VS Code-style tabs)
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
