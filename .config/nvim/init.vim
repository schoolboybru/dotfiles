call plug#begin("~/.config/nvim/plugged")
  Plug 'morhetz/gruvbox'
  Plug 'Mofiqul/dracula.nvim'
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin' 
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim' 
  Plug 'ryanoasis/vim-devicons'
  Plug 'itchyny/lightline.vim'
  Plug 'w0rp/ale'
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' },
  Plug 'airblade/vim-gitgutter',
  Plug 'joshdick/onedark.vim',
  Plug 'nvim-lua/popup.nvim',
  Plug 'nvim-lua/plenary.nvim',
  Plug 'nvim-telescope/telescope.nvim',
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' },
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'} 
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()

set relativenumber

if (has("termguicolors"))
	set termguicolors
endif
set background=dark
colorscheme dracula

nnoremap <C-p> :Files<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Lightline
let g:lightline = {
  \     'colorscheme': 'powerlineish',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

" ALE (Asynchronous Lint Engine)
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" TELESCOPE STUFF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>

lua require("schoolboybru")
