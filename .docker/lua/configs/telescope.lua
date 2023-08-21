local actions = require 'telescope.actions'
local api     = vim.api

local function set_map(map, cmd_name)
  return api.nvim_set_keymap('n', map, "<cmd>lua require('telescope.builtin')."..cmd_name.."()<cr>", {
    noremap = true,
    silent  = true
  })
end

local function set_map_raw(map, cmd)
  return api.nvim_set_keymap('n', map, cmd, {
    noremap = true,
    silent  = true
  })
end

set_map('ff', 'find_files')
set_map('fg', 'live_grep')
set_map('fb', 'buffers')
set_map('fh', 'help_tags')

set_map_raw('fd', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>')
set_map_raw('<C-P>', '<cmd>Telescope commands<cr>')
set_map_raw('tt', '<cmd>Telescope<cr>')

require 'telescope'.setup {
  defaults = {
    initial_mode = 'insert',
    file_ignore_patterns = { '.git' },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    color_devicons = true,
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["<c-d>"] = require'telescope.actions'.delete_buffer,
        }
      }
    }
  },
}
