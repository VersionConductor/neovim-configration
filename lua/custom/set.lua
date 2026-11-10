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
opt.autoindent = true

-- Line wrapping
opt.wrap = false
opt.scrolloff = 8
opt.colorcolumn = "80"

-- Search
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "./.config/nvim/undodir"
opt.undofile = true
opt.clipboard = "unnamed"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1"

-- Performance
opt.updatetime = 50

-- Other
opt.isfname:append("@-@")
opt.cursorline = true

--search query dynamic
opt.ignorecase = true
opt.smartcase = true

-- copilot autocomplete
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.keymap.set("i", "<M-l>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
    desc = "Accept Copilot Suggestion",
})