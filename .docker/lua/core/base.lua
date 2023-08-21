-- Command shortcuts
local opt = vim.opt
local api = vim.api
local cmd = vim.cmd

-- Mouse support
opt.mouse = 'a'

-- Whitespaces
opt.listchars = 'tab:›  ,trail:~,extends:>,precedes:<,space:∙'
--opt.listchars = 'tab:›  ,trail:~,extends:>,precedes:<,space:ᐧ'
--opt.listchars = 'tab:▸  ,trail:~,extends:>,precedes:<,space:∙'
-- opt.listchars = 'tab:›  ,trail:~,precedes:«,extends:»,space:∙,eol:¬'
opt.list      = true  -- Show the whitespace character

-- Line numbers
opt.nu  = true  -- Turn on line number
opt.rnu = true  -- Set as relative mode

-- Tab and spaces
opt.expandtab  = true
opt.smarttab   = true
opt.shiftwidth = 4
opt.tabstop    = 4
opt.lbr        = true  -- linebreak
opt.tw         = 2048  -- text width
opt.ai         = true  -- Auto indent
opt.si         = true  -- Smart indent
opt.smartcase  = true

-- Misc
opt.completeopt = {'menu', 'menuone', 'noinsert', 'noselect'}
opt.wildmode    = {'list', 'longest'} -- Command-line completion mode
opt.splitbelow  = true                -- Put new windows below current
opt.splitright  = true                -- Put new windows right of current

opt.wrap   = false  -- Line wrap
opt.hidden = true   -- Enable Background buffers

opt.shortmess = opt.shortmess + 'c'

-- jk to escape
api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

-- Global options
vim.o.wildmenu = true    -- Command line completion mode
vim.o.wildmode = 'full'  -- Command line completion mode

-- Turn off line numbers in terminal mode
api.nvim_command('autocmd TermOpen * setlocal nonu nornu nolist')
api.nvim_command('autocmd TermEnter * setlocal nonu nornu nolist')

-- Set wrap for LaTeX, Markdown
api.nvim_command('autocmd BufRead,BufNewFile *.tex set wrap')
api.nvim_command('autocmd BufRead,BufNewFile *.md set wrap')

-- Escape from insert mode in terminal
api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

api.nvim_set_keymap('n', '<space>w', '<C-w>', { noremap = true })

--api.nvim_buf_set_keymap(0, 'n', '<A-j>', ':m .+1<CR>==', { noremap = true})
--api.nvim_buf_set_keymap(0, 'n', '<A-k>', ':m .-1<CR>==', { noremap = true})
api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true})
api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true})

-- MinWhiteSpace
-- AllWhiteSpace

-- Notes
-- <C-e> - scroll down
-- <C-y> - scroll up
-- zH    - Go all the way to the left  horizontally
-- zL    - Go all the way to the right horizontally
-- zh    - Go left
-- zl    - Go right
