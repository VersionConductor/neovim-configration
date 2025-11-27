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
 
-- greatest keymap
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])