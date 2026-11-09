
return {
    {
        "nvim-lualine/lualine.nvim",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        event = "VeryLazy",

        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {
                        left = "│",
                        right = "│",
                    },
                    section_separators = {
                        left = "",
                        right = "",
                    },
                    globalstatus = true,
                    disabled_filetypes = {
                        statusline = {
                            "dashboard",
                            "alpha",
                            "starter",
                        },
                    },
                },

                sections = {
                    lualine_a = {
                        {
                            "mode",
                            icon = "",
                        },
                    },

                    lualine_b = {
                        {
                            "branch",
                            icon = "",
                        },
                        {
                            "diff",
                            symbols = {
                                added = " ",
                                modified = " ",
                                removed = " ",
                            },
                        },
                    },

                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                            symbols = {
                                modified = " ●",
                                readonly = " ",
                                unnamed = "[No Name]",
                            },
                        },
                    },

                    lualine_x = {
                        {
                            "diagnostics",
                            sources = {
                                "nvim_diagnostic",
                            },
                            symbols = {
                                error = " ",
                                warn = " ",
                                info = " ",
                                hint = "󰌵 ",
                            },
                        },
                        "encoding",
                        "fileformat",
                        "filetype",
                    },

                    lualine_y = {
                        "progress",
                    },

                    lualine_z = {
                        {
                            "location",
                            icon = "",
                        },
                    },
                },

                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        "filename",
                    },
                    lualine_x = {
                        "location",
                    },
                    lualine_y = {},
                    lualine_z = {},
                },

                extensions = {
                    "fugitive",
                    "nvim-tree",
                    "lazy",
                    "quickfix",
                    "toggleterm",
                },
            })
        end,
    },
}
