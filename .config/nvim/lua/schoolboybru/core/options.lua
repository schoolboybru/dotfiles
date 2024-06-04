vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & Indentation --
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Search settings --
opt.ignorecase = true
opt.smartcase = true

-- Backspace --
opt.backspace = "indent,eol,start"

-- Clipboard --
opt.clipboard:append("unnamedplus")

-- Split windows --
opt.splitright = true
opt.splitbelow = true
