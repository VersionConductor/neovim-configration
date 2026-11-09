
return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.0",

        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                    },

                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close,
                        },
                    },
                },
            })

            pcall(telescope.load_extension, "fzf")

            -- Find files
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {
                desc = "Telescope: Find files",
            })

            -- Git files
            vim.keymap.set("n", "<C-p>", builtin.git_files, {
                desc = "Telescope: Git files",
            })

            -- Buffers
            vim.keymap.set("n", "<C-b>", builtin.buffers, {
                desc = "Telescope: Buffers",
            })

            -- Live grep
            vim.keymap.set("n", "<leader>lg", builtin.live_grep, {
                desc = "Telescope: Live grep",
            })

            -- Help tags
            vim.keymap.set("n", "<leader>vh", builtin.help_tags, {
                desc = "Telescope: Help tags",
            })
        end,
    },
}