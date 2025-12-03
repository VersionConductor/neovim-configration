return {
    {
        'nvim-telescope/telescope.nvim', 
        tag = 'v0.2.0',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require('telescope.builtin')

            -- telescope some setup
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git" },
                    mappings = {
                        i = {
                            ["<Esc>"] = require("telescope.actions").close
                        }
                    }
                }
            })

            -- Load fzf-native if installed
            pcall(telescope.load_extension, "fzf")

            -- find files
            vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
            
            -- Fuzzy search git files
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })

            -- buffers
            vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Telescope buffers' })

            -- live grep
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })

            -- help tags
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    }
}

