-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>']     = cmp.mapping.select_prev_item(),
    ['<C-p>']     = cmp.mapping.select_prev_item(),
    ['<S-Tab>']   = cmp.mapping.select_prev_item(),
    ['<C-n>']     = cmp.mapping.select_next_item(),
    ['<Tab>']     = cmp.mapping.select_next_item(),
    ['<Down>']     = cmp.mapping.select_next_item(),

    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select   = true
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  --mapping = {
  --  ['<C-p>']     = cmp.mapping.select_prev_item(),
  --  ['<S-Tab>']   = cmp.mapping.select_prev_item(),
  --  ['<C-n>']     = cmp.mapping.select_next_item(),
  --  ['<Tab>']     = cmp.mapping.select_next_item(),
  --  ['<C-d>']     = cmp.mapping.scroll_docs(-4),
  --  ['<C-f>']     = cmp.mapping.scroll_docs(4),
  --  ['<C-Space>'] = cmp.mapping.complete(),
  --  ['<C-e>']     = cmp.mapping.close(),
  --  ['<CR>']      = cmp.mapping.confirm({
  --    select = true
  --  })
  --},
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer'   },
  },
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources(
    {
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    },
    {
      { name = 'buffer' },
    }
  )
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = 'path' }
    },
    {
      { name = 'cmdline' }
    }
  )
})


