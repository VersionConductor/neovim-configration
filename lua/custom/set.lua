local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.scrolloff = 8
opt.colorcolumn = "80"

-- Search
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Performance
opt.updatetime = 50

-- Other
opt.isfname:append("@-@")