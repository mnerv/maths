return {
  -- { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "lervag/vimtex" },
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  {
  "neovim/nvim-lspconfig",
    opts = {
      servers = { }
    },
  },
}
