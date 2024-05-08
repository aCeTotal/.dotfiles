local o = vim.opt
local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

vim.api.nvim_set_hl(0, "Normal", {guibg=NONE, ctermbg=NONE})


map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map('n', '<C-n>', ':Telescope live_grep <CR>', opts)
map('n', '<C-f>', ':Telescope find_files <CR>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', ';', ':', { noremap = true } )

g.mapleader = ' '

-- Performance
o.lazyredraw = true;
o.shell = "zsh"
o.shadafile = "NONE"

-- Colors
o.termguicolors = true

-- Undo files
o.undofile = true

-- Indentation
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.shiftround = true
o.expandtab = true
o.scrolloff = 3

-- Set clipboard to use system clipboard
o.clipboard = "unnamedplus"

-- Use mouse
o.mouse = "a"

-- Nicer UI settings
o.cursorline = true
o.relativenumber = true
o.number = true

-- Get rid of annoying viminfo file
o.viminfo = ""
o.viminfofile = "NONE"

-- Miscellaneous quality of life
o.ignorecase = true
o.ttimeoutlen = 5
o.hidden = true
o.shortmess = "atI"
o.wrap = false
o.backup = false
o.writebackup = false
o.errorbells = false
o.swapfile = false
o.showmode = false
o.laststatus = 3
o.pumheight = 6
o.splitright = true
o.splitbelow = true
o.completeopt = "menuone,noselect"
