-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.cursorline = true
vim.o.laststatus = 0



-- Install packer if not installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end

-- Packer Plugins
require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  use 'dracula/vim'

  use "hrsh7th/vim-jsregexp"

  use {
    'mcchrish/nnn.vim',
    config = function()
      vim.g.nnn_command = 'nnn -ade'
      vim.g.nnn_layout = {
        window = {
          width = 0.9,
          height = 0.8,
          xoffset = 0.05,
          yoffset = 0.05,
          border = 'rounded'
        }
      }
    end
  }

  use 'preservim/nerdtree'
  use 'ThePrimeagen/harpoon'
  use 'nvim-telescope/telescope.nvim'
  use 'alexghergh/nvim-tmux-navigation'
  --use 'Exafunction/codeium.vim'

  -- LSP and Completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Additional Plugins for C Development
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "jose-elias-alvarez/null-ls.nvim"
  use 'nvim-lua/plenary.nvim'
end)

require('nvim-tmux-navigation').setup({
  disable_when_zoomed = true
})

-- Set colorscheme
vim.cmd('colorscheme dracula')

-- Treesitter Configuration (for C)
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c" },
  highlight = { enable = true },
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "java" },
  highlight = { enable = true },
}

-- Null-ls Configuration (for formatting and linting in C)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.clang_check,
  },
})

-- Autocompletion for brackets and quotes
vim.cmd([[
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>
inoremap ` ``<Left>
]])

-- Automatically install missing plugins on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Keybindings for tab navigation
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', 'gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', 'gT', { noremap = true })

-- Set up basic key mappings for Harpoon
local harpoon = require('harpoon')
local map = vim.api.nvim_set_keymap

-- Mark the current file
map('n', '<Leader>m', '<Cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })

-- Toggle Harpoon menu
map('n', '<Leader>h', '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })

-- Navigate to the next/previous marked file
map('n', '<Leader>n', '<Cmd>lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
map('n', '<Leader>p', '<Cmd>lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Leader>f', function()
    builtin.find_files({ hidden = true })
end, { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>g', function()
    require('telescope.builtin').live_grep({
        additional_args = function() return { "--hidden" } end
    })
end, { noremap = true, silent = true })

local nvim_tmux_nav = require('nvim-tmux-navigation')

-- Map <Leader>n to open nnn
vim.api.nvim_set_keymap('n',
  '<Leader>q',
  ':NnnPicker<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<Leader>e', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, { noremap = true, silent = true })
vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive, { noremap = true, silent = true })
vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext, { noremap = true, silent = true })


vim.o.background = "dark"
vim.cmd("highlight Normal guibg=black")



vim.cmd("highlight LineNr guifg=#d8a657")
vim.cmd("highlight CursorLineNr guifg=#fabd2f")

