
return {
    {
        "tpope/vim-fugitive",

        cmd = {
            "Git",
            "G",
        },

        keys = {
            {
                "<leader>gs",
                "<cmd>Git<CR>",
                desc = "Git: Status",
            },
        },

        config = function()
            local map = vim.keymap.set

            -- Fugitive keybindings
            local Fugitive = vim.api.nvim_create_augroup(
                "Fugitive",
                { clear = true }
            )

            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = Fugitive,
                pattern = "*",

                callback = function()
                    if vim.bo.filetype ~= "fugitive" then
                        return
                    end

                    local opts = {
                        buffer = true,
                        remap = false,
                        silent = true,
                    }

                    -- Git push
                    map("n", "<leader>p", function()
                        vim.cmd.Git("push")
                    end, vim.tbl_extend("force", opts, {
                        desc = "Git: Push",
                    }))

                    -- Git pull with rebase
                    map("n", "<leader>P", function()
                        vim.cmd.Git({
                            "pull",
                            "--rebase",
                        })
                    end, vim.tbl_extend("force", opts, {
                        desc = "Git: Pull with rebase",
                    }))

                    -- Push and set upstream branch
                    map("n", "<leader>t", ":Git push -u origin ", vim.tbl_extend("force", opts, {
                        desc = "Git: Push and set upstream",
                    }))
                end,
            })

            -- Diff navigation
            map("n", "gu", "<cmd>diffget //2<CR>", {
                desc = "Git: Get changes from target",
            })

            map("n", "gh", "<cmd>diffget //3<CR>", {
                desc = "Git: Get changes from merge",
            })
        end,
    },
}
