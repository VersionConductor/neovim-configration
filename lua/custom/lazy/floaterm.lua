return {
    'voldikss/vim-floaterm',
    config = function()
         -- Floaterm position and size
        vim.g.floaterm_position = "center"  -- "top", "bottom", "left", "right", "center"
        vim.g.floaterm_height   = 0.3       -- 30% of editor height if bottom/top
        vim.g.floaterm_width    = 0.8       -- 80% width if center

        -- -- Floaterm keymaps
        -- vim.g.floaterm_keymap_new    = '<leader>fc'
        -- vim.g.floaterm_keymap_prev   = '<leader>fp'
        -- vim.g.floaterm_keymap_next   = '<leader>fn'
        -- vim.g.floaterm_keymap_toggle = '<leader>ft'
        -- vim.g.floaterm_keymap_kill   = '<leader>fk'

        -- Custom leader keymaps instead of vim.g.floaterm_keymap_*
        local map = vim.keymap.set
        local opts = { noremap: true, silent: true }

        map("n", "<leader>fc", ":FloatermNew<CR>", opts)
        map("n", "<leader>fn", ":FloatermNext<CR>", opts)
        map("n", "<leader>fp", ":FloatermPrev<CR>", opts)
        map("n", "<leader>ft", ":FloatermToggle<CR>", opts)
        map("n", "<leader>fk", ":FloatermKill<CR>", opts)
    end
}
