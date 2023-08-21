local cmd = vim.cmd
local g   = vim.g
local opt = vim.opt
local api = vim.api
local fn  = vim.fn

vim.cmd [[packadd packer.nvim]]

-- List of packages https://github.com/rockerBOO/awesome-neovim
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Command Palette
  -- Requires: 'ripgrep'
  -- Optinoal: 'fd'
  -- Use checkhealth telescope for more info
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config   = function() require'configs.telescope' end,
  }

  -- Tree file view
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config   = function()
      require'nvim-tree'.setup {}
      vim.api.nvim_set_keymap('n', '<space>t', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require'gitsigns'.setup{
        current_line_blame = true
      }
    end,
  }
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local neogit = require('neogit')
      neogit.setup {}
    end
  }

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true
        }
      }
      --vim.o.foldmethod = 'expr'
      --vim.o.foldexpr   = "nvim_treesitter#foldexpr()"
    end,
  }
  use 'tikhomirov/vim-glsl'

  use {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require 'todo-comments'.setup{
      }
    end
  }

  use {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require 'trouble'.setup{}
    end
  }

  -- Language Server Protocol
  use {
    'neovim/nvim-lspconfig',
    config = function() require'configs.lsp' end,
  }

  -- LaTeX support
  use 'lervag/vimtex'

  -- Github Copilot
  use 'github/copilot.vim'

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Snippets
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config   = function() require'configs.cmp' end
  }

  -- Navigation
  --   Use `s` to run
  use 'ggandor/lightspeed.nvim'

  -- Terminal
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require'toggleterm'.setup{
        open_mapping = [[<c-j>]]
      }
    end
  }

  -- Theme
  use {
    'sainnhe/sonokai',
    config = function()
      require 'configs.sonokai'  -- Activate sonokai theme
    end
  }

  -- Statusline
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config   = function() require'configs.lualine' end,
  }

  local function replace_code(str)
    return api.nvim_replace_termcodes(str, true, true, true)
  end
  function _G.smart_tab()
    return fn.pumvisible() == 1 and replace_code'<C-n>' or replace_code'<Tab>'
  end
  api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})

  api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
  g.copilot_no_tab_map = true
end)
