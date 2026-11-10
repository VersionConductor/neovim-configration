vim.g.mapleader = " "
vim.opt.guicursor = ""

-- vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open Explorer" })
map("n", "<leader><leader>", "<cmd>source %<CR>", { desc = "Reload Current File" })
map("n", "Q", "<nop>")

-- Folding
map("n", "<leader>z", "za", { desc = "Toggle Fold" })
map("n", "<leader>o", "zo", { desc = "Open Fold" })
map("n", "<leader>c", "zc", { desc = "Close Fold" })

-- File Explorer
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer" })

-- Move lines
map("n", "<leader>k", ":move-2<CR>==", { desc = "Move Line Up" })
map("n", "<leader>j", ":move+<CR>==", { desc = "Move Line Down" })
map("v", "<leader>k", ":move '<-2<CR>gv=gv", { desc = "Move Selection Up" })
map("v", "<leader>j", ":move '>+<CR>gv=gv", { desc = "Move Selection Down" })

-- Clipboard
map("x", "<leader>p", [["_dP]], { desc = "Paste Without Overwriting Register" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank Line to Clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete Without Yanking" })

-- Editing
map("i", "<C-c>", "<Esc>", { desc = "Escape Insert Mode" })
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = "Replace Word Under Cursor",
})
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make File Executable" })

-- LSP
map("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format Document" })

-- Quickfix List
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix Item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix Item" })

-- Location List
map("n", "[l", "<cmd>lnext<CR>zz", { desc = "Next Location Item" })
map("n", "]l", "<cmd>lprev<CR>zz", { desc = "Previous Location Item" })

-- Tmux
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", {
    desc = "Open Tmux Sessionizer",
})

-- Theme
-- map("n", "<leader>th", function()
--     ThemeSelector()
-- end, { desc = "Select Colorscheme" })

vim.keymap.set("n", "<leader>th", function()
    require("telescope.builtin").colorscheme({
        enable_preview = true,
    })
end, { desc = "Select Colorscheme" })
