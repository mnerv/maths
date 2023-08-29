-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_config_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("commentstring"),
  pattern = { "cc", "c", "h", "hpp", "cpp" },
  callback = function()
    vim.opt.commentstring = "// %s"
  end,
  desc = "Change commentstring for c/c++ files",
})

-- Wrap for special files
vim.api.nvim_command("autocmd BufRead,BufNewFile *.tex set wrap")
vim.api.nvim_command("autocmd BufRead,BufNewFile *.tex set linebreak")
vim.api.nvim_command("autocmd BufRead,BufNewFile *.md set wrap")
vim.api.nvim_command("autocmd BufRead,BufNewFile *.md set linebreak")

-- Escape from insert mode in terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
