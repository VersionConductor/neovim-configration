vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- folding keymaps
-- Toggle fold
-- Open fold
-- Close fold

vim.api.nvim_set_keymap('n', '<leader>z', 'za', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<leader>o', 'zo', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<leader>c', 'zc', { noremap = true, silent = true })

-- neotree keymaps
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')

-- Move current line up/down (with optional count)
vim.keymap.set('n', '<leader>k', ':move-2<CR>==', {desc = 'Move line up'})
vim.keymap.set('n', '<leader>j', ':move+<CR>==', {desc = 'Move line down'})
vim.keymap.set('v', '<leader>k', ":move'<-2<CR>gv=gv", {desc = 'Move selection up'})
vim.keymap.set('v', '<leader>j', ":move'>+<CR>gv=gv", {desc = 'Move selection down'})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

