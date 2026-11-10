
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",

        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                component_separators = "|",
                section_separators = "",
                disabled_filetypes = {
                    statusline = {
                        "dashboard",
                        "alpha",
                        "starter",
                    },
                },
            },

            sections = {
                lualine_a = { "mode" },

                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                },

                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        file_status = true,
                    },
                },

                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },

                lualine_y = { "progress" },

                lualine_z = { "location" },
            },

            inactive_sections = {
                lualine_c = { "filename" },
                lualine_x = { "location" },
            },

            extensions = {
                "fugitive",
                "nvim-tree",
                "lazy",
                "quickfix",
                "toggleterm",
            },
        },
    },
}
