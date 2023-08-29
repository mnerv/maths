vim.g["sonokai_style"] = "andromeda"

return {
  { "sainnhe/sonokai" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000},
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
