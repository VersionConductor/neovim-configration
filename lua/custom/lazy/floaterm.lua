return {
    'voldikss/vim-floaterm',
    config = function()
         -- Floaterm position and size
        vim.g.floaterm_position = "center"  -- "top", "bottom", "left", "right", "center"
        vim.g.floaterm_height   = 0.3       -- 30% height
        vim.g.floaterm_width    = 0.8       -- 80% width

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        map("n", "<leader>fc", ":FloatermNew<CR>", opts)
        map("n", "<leader>fn", ":FloatermNext<CR>", opts)
        map("n", "<leader>fp", ":FloatermPrev<CR>", opts)
        map("n", "<leader>ft", ":FloatermToggle<CR>", opts)
        map("n", "<leader>fk", ":FloatermKill<CR>", opts)
    end
}
