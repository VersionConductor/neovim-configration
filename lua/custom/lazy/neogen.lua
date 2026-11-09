
return {
    {
        "danymat/neogen",

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        cmd = "Neogen",

        keys = {
            {
                "<leader>nf",
                function()
                    require("neogen").generate({
                        type = "func",
                    })
                end,
                desc = "Neogen: Generate function documentation",
            },

            {
                "<leader>nc",
                function()
                    require("neogen").generate({
                        type = "class",
                    })
                end,
                desc = "Neogen: Generate class documentation",
            },

            {
                "<leader>nt",
                function()
                    require("neogen").generate({
                        type = "type",
                    })
                end,
                desc = "Neogen: Generate type documentation",
            },

            {
                "<leader>na",
                function()
                    require("neogen").generate()
                end,
                desc = "Neogen: Generate annotations",
            },
        },

        opts = {
            enabled = true,
            input_after_comment = true,
            snippet_engine = "nvim",
        },
    },
}
