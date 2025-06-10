-- Basic Neovim configuration
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.mouse = 'a'                  -- Enable mouse support
vim.opt.ignorecase = true           -- Ignore case in search
vim.opt.smartcase = true            -- Override ignorecase if search contains capitals
vim.opt.incsearch = true            -- Show search matches as you type
vim.opt.hlsearch = true             -- Highlight search matches
vim.opt.wrap = false                -- Don't wrap lines
vim.opt.breakindent = true          -- Preserve indentation in wrapped text
vim.opt.tabstop = 4                 -- Number of spaces that a tab counts for
vim.opt.shiftwidth = 4              -- Number of spaces to use for autoindent
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.autoindent = true           -- Copy indent from current line when starting a new line
vim.opt.smartindent = true          -- Smart autoindenting when starting a new line
vim.opt.cursorline = true           -- Highlight current line
vim.opt.termguicolors = true        -- Enable true color support
vim.opt.signcolumn = 'yes'          -- Always show sign column
vim.opt.updatetime = 300            -- Faster completion
vim.opt.timeoutlen = 500            -- By default timeoutlen is 1000 ms
vim.opt.clipboard = 'unnamedplus'    -- Use system clipboard
vim.opt.scrolloff = 8               -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8           -- Keep 8 columns left/right of cursor
vim.opt.backup = false              -- Don't create backup files
vim.opt.writebackup = false         -- Don't create backup files
vim.opt.swapfile = false            -- Don't create swap files
vim.opt.undofile = true             -- Enable persistent undo
vim.opt.splitbelow = true           -- Open new split below
vim.opt.splitright = true           -- Open new split right

-- Basic key mappings
vim.g.mapleader = ' '               -- Set leader key to space

-- Basic autocommands
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]]
