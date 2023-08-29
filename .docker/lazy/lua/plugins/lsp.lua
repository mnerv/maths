return {
  { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "lervag/vimtex" },
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },

  --{ "williamboman/mason.nvim" },
  --{
  --  "williamboman/mason-lspconfig.nvim",
  --  opts = {
  --    automatic_installation = false,
  --    ensure_installed = {
  --      "ltex"
  --    },
  --  }
  --},
  {
  "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = { }
    },
  },
}
