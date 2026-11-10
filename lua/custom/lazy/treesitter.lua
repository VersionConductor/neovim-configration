
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "html",
                    "javascript",
                    "typescript",
                    "tsx",
                    "php",
                    "bash",
                    "json",
                },

                sync_install = false,
                auto_install = true,

                indent = {
                    enable = true,
                },

                fold = {
                    enable = true,
                },

                incremental_selection = {
                    enable = true,
                },

                highlight = {
                    enable = true,

                    disable = function(lang, buf)
                        -- Disable Treesitter highlighting for HTML
                        if lang == "html" then
                            return true
                        end

                        -- Disable for files larger than 100 KB
                        local max_filesize = 100 * 1024
                        local filename = vim.api.nvim_buf_get_name(buf)
                        local ok, stats = pcall(vim.loop.fs_stat, filename)

                        if ok and stats and stats.size > max_filesize then
                            vim.notify(
                                "File larger than 100KB. Treesitter disabled for performance.",
                                vim.log.levels.WARN,
                                { title = "Treesitter" }
                            )
                            return true
                        end

                        return false
                    end,

                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
}