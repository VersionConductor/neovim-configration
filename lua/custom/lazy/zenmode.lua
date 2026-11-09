
return {
    {
        "folke/zen-mode.nvim",

        dependencies = {
            "folke/twilight.nvim",
        },

        config = function()
            local zen = require("zen-mode")
            local twilight = require("twilight")

            -- Twilight configuration
            twilight.setup({
                dimming = {
                    alpha = 0.25,
                    color = { "Normal", "#ffffff" },
                    term_bg = "#000000",
                    inactive = false,
                },

                context = 10,

                treesitter = true,

                expand = {
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },

                exclude = {},
            })

            -- Zen Mode configuration
            zen.setup({
                window = {
                    width = 90,

                    options = {
                        signcolumn = "no",
                        number = true,
                        relativenumber = true,
                        cursorline = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                        wrap = false,
                    },
                },

                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = false,
                    },

                    twilight = {
                        enabled = true,
                    },

                    gitsigns = {
                        enabled = false,
                    },

                    tmux = {
                        enabled = false,
                    },
                },
            })

            -- Normal Zen Mode
            vim.keymap.set("n", "<leader>zz", function()
                zen.setup({
                    window = {
                        width = 90,
                        options = {
                            wrap = false,
                            number = true,
                            relativenumber = true,
                        },
                    },
                })

                zen.toggle()
            end, {
                desc = "Zen Mode: Normal",
            })

            -- Minimal Zen Mode
            vim.keymap.set("n", "<leader>zZ", function()
                zen.setup({
                    window = {
                        width = 80,
                        options = {
                            wrap = false,
                            number = false,
                            relativenumber = false,
                            colorcolumn = "0",
                        },
                    },
                })

                zen.toggle()
            end, {
                desc = "Zen Mode: Minimal",
            })

            -- Toggle Twilight independently
            vim.keymap.set("n", "<leader>zt", function()
                twilight.toggle()
            end, {
                desc = "Twilight: Toggle",
            })
        end,
    },
}
