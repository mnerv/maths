-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.listchars = 'tab:›  ,trail:~,extends:>,precedes:<,space:∙'
vim.opt.clipboard = "" -- Don't sync with system clipboard
vim.opt.showmode = true

vim.o.linebreak = true   -- Break at convenient place
vim.o.wildmenu  = true   -- Command line completion mode
vim.o.wildmode  = "full" -- Command line completion mode

vim.g.autoformat = false
