
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        opts = {
            preset = "modern",
            delay = 300,
            icons = {
                mappings = true,
            },
        },

        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({
                        global = false,
                    })
                end,
                desc = "Buffer Local Keymaps",
            },
        },
    },
}
