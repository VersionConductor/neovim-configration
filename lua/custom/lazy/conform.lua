
return {
    {
        "stevearc/conform.nvim",

        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    -- JavaScript / TypeScript
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },

                    -- Web
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    json = { "prettier" },
                    jsonc = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },

                    -- PHP / Laravel
                    php = { "pint" },

                    -- Lua
                    lua = { "stylua" },
                },

                format_on_save = {
                    timeout_ms = 3000,
                    lsp_format = "fallback",
                },

                formatters = {
                    prettier = {
                        prepend_args = { "--single-quote" },
                    },
                },
            })

            -- Manual formatting
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                conform.format({
                    async = true,
                    lsp_format = "fallback",
                })
            end, {
                desc = "Format file",
            })
        end,
    },
}

