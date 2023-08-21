local g   = vim.g
local fn  = vim.fn
local opt = vim.opt
local cmd = vim.cmd

if fn.has('termguicolors') then
  opt.termguicolors = true
end

-- Sonokai color scheme settings
g['sonokai_style']                   = 'andromeda'
g['sonokai_enable_italic']           = 1
g['sonokai_disable_itallic_comment'] = 1
g['airline_theme']                   = 'sonokai'
cmd 'colorscheme sonokai'
