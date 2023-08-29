return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local logo = {
        [[          ▀████▀▄▄              ▄█ ]],
        [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
        [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
        [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
        [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
        [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
        [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
        [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
        [[   █   █  █      ▄▄           ▄▀   ]],
      }
      opts.section.header.val = logo
    end,
  }
}
