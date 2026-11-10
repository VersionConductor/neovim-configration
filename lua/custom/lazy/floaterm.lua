
return {
    {
        "voldikss/vim-floaterm",

        config = function()
            -- Floaterm appearance
            vim.g.floaterm_position = "center"
            vim.g.floaterm_height = 0.3
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

            -- Terminal behavior
            vim.g.floaterm_autoclose = 2
            vim.g.floaterm_title = " Terminal $1/$2 "

            local map = vim.keymap.set

            -- Normal mode keybindings
            map("n", "<leader>fc", "<cmd>FloatermNew<CR>", {
                desc = "Floaterm: Create terminal",
                silent = true,
            })

            map("n", "<leader>ft", "<cmd>FloatermToggle<CR>", {
                desc = "Floaterm: Toggle terminal",
                silent = true,
            })

            map("n", "<leader>fn", "<cmd>FloatermNext<CR>", {
                desc = "Floaterm: Next terminal",
                silent = true,
            })

            map("n", "<leader>fp", "<cmd>FloatermPrev<CR>", {
                desc = "Floaterm: Previous terminal",
                silent = true,
            })

            map("n", "<leader>fk", "<cmd>FloatermKill<CR>", {
                desc = "Floaterm: Kill terminal",
                silent = true,
            })

            -- Terminal mode: exit to normal mode
            map("t", "<Esc>", [[<C-\><C-n>]], {
                desc = "Floaterm: Exit terminal mode",
                silent = true,
            })

            -- Terminal mode: toggle terminal
            map("t", "<C-e>", [[<C-\><C-n><cmd>FloatermToggle<CR>]], {
                desc = "Floaterm: Toggle terminal",
                silent = true,
            })
        end,
    },
}
