return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        initial_mode = 'insert',
        file_ignore_patterns = { '.git' },
        mappings = {
          i = {
            ["<esc>"] = require('telescope.actions').close,
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
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
  }
}
