return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        icons = false,
    },
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Toggle Diagnostics",
        },
        {
            "[t",
            function()
                require("trouble").next({ skip_groups = true, jump = true })
            end,
            desc = "Next Trouble Item",
        },
        {
            "]t",
            function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end,
            desc = "Previous Trouble Item",
        },
    },
}