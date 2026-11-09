
return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },

        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                },
            })

            local list = harpoon:list()

            -- =========================================
            -- Telescope UI for Harpoon
            -- =========================================

            local function harpoon_telescope()
                local conf = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                local file_paths = {}

                for _, item in ipairs(list.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon Files",

                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),

                    sorter = conf.generic_sorter({}),

                    previewer = conf.file_previewer({}),

                    attach_mappings = function(prompt_bufnr, map)

                        -- Open selected file
                        actions.select_default:replace(function()
                            local selection =
                                action_state.get_selected_entry()

                            actions.close(prompt_bufnr)

                            if selection then
                                vim.cmd(
                                    "edit " ..
                                    vim.fn.fnameescape(selection[1])
                                )
                            end
                        end)

                        -- Remove selected file
                        local function remove_file()
                            local selection =
                                action_state.get_selected_entry()

                            if not selection then
                                return
                            end

                            local index = selection.index

                            table.remove(list.items, index)

                            actions.close(prompt_bufnr)

                            harpoon_telescope()
                        end

                        map("i", "<C-d>", remove_file)
                        map("n", "<C-d>", remove_file)

                        return true
                    end,
                }):find()
            end

            -- =========================================
            -- Add / Prepend files
            -- =========================================

            vim.keymap.set("n", "<leader>a", function()
                list:add()
            end, {
                desc = "Harpoon: Add file",
            })

            vim.keymap.set("n", "<leader>A", function()
                list:prepend()
            end, {
                desc = "Harpoon: Prepend file",
            })

            -- =========================================
            -- Telescope menu
            -- =========================================

            vim.keymap.set("n", "<C-e>", harpoon_telescope, {
                desc = "Harpoon: Telescope menu",
            })

            -- =========================================
            -- Select marked files
            -- =========================================

            vim.keymap.set("n", "<C-h>", function()
                list:select(1)
            end, {
                desc = "Harpoon: File 1",
            })

            vim.keymap.set("n", "<C-t>", function()
                list:select(2)
            end, {
                desc = "Harpoon: File 2",
            })

            vim.keymap.set("n", "<C-n>", function()
                list:select(3)
            end, {
                desc = "Harpoon: File 3",
            })

            vim.keymap.set("n", "<C-s>", function()
                list:select(4)
            end, {
                desc = "Harpoon: File 4",
            })

            -- =========================================
            -- Replace marked files
            -- =========================================

            vim.keymap.set("n", "<leader><C-h>", function()
                list:replace_at(1)
            end, {
                desc = "Harpoon: Replace file 1",
            })

            vim.keymap.set("n", "<leader><C-t>", function()
                list:replace_at(2)
            end, {
                desc = "Harpoon: Replace file 2",
            })

            vim.keymap.set("n", "<leader><C-n>", function()
                list:replace_at(3)
            end, {
                desc = "Harpoon: Replace file 3",
            })

            vim.keymap.set("n", "<leader><C-s>", function()
                list:replace_at(4)
            end, {
                desc = "Harpoon: Replace file 4",
            })

            -- =========================================
            -- Previous / Next navigation
            -- =========================================

            vim.keymap.set("n", "<C-S-P>", function()
                list:prev()
            end, {
                desc = "Harpoon: Previous file",
            })

            vim.keymap.set("n", "<C-S-N>", function()
                list:next()
            end, {
                desc = "Harpoon: Next file",
            })
        end,
    },
}