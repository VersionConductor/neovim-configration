return {
    -- Mason: LSP installer
     {
        "williamboman/mason.nvim",
        cmd = "Mason",
        -- opts = {
        --     ui = {
        --         border = "rounded",
        --         icons = {
        --             package_installed = "✓",
        --             package_pending = "➜",
        --             package_uninstalled = "✗",
        --         },
        --     },
        -- },
        config = function()
            reqiure("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                }
            })
        end
    },

    -- Mason LSP bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        -- opts = {
        --     ensure_installed = {
        --         "lua_ls",
        --         "ts_ls",
        --         "html",
        --         "cssls",
        --         "intelephense",
        --         "emmet_language_server",
        --         "jsonls",
        --         "eslint",
        --         "tailwindcss",
        --     },

        --     -- We will enable servers manually below.
        --     automatic_enable = false,
        -- },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "intelephense",
                "emmet_language_server",
                "jsonls",
                "eslint",
                "tailwindcss",
            },

                -- We will enable servers manually below.
                automatic_enable = false,
            })
        end
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            -- Common LSP capabilities and configuration
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },

                ts_ls = {},

                html = {},

                cssls = {},

                intelephense = {},

                emmet_language_server = {
                    filetypes = {
                        "html",
                        "css",
                        "javascriptreact",
                        "typescriptreact",
                    },
                },

                jsonls = {},

                eslint = {},

                tailwindcss = {},
            }

            -- Configure and enable all servers
            for server, config in pairs(servers) do
                config.capabilities = capabilities

                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end

            -- LSP keybindings
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup(
                    "UserLspConfig",
                    { clear = true }
                ),

                callback = function(event)
                    local opts = {
                        buffer = event.buf,
                        silent = true,
                    }

                    local map = vim.keymap.set

                    map("n", "gd", vim.lsp.buf.definition, opts)
                    map("n", "gD", vim.lsp.buf.declaration, opts)
                    map("n", "gi", vim.lsp.buf.implementation, opts)
                    map("n", "gr", vim.lsp.buf.references, opts)

                    map("n", "K", vim.lsp.buf.hover, opts)

                    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                    map("n", "<leader>d", vim.diagnostic.open_float, opts)
                    map("n", "[d", vim.diagnostic.goto_prev, opts)
                    map("n", "]d", vim.diagnostic.goto_next, opts)

                    map("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,

                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
      -- Autocompletion
    {
        "hrsh7th/nvim-cmp",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Load VSCode snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-e>"] = cmp.mapping.abort(),

                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                    }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                }),

                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
            })
        end,
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     dependencies = {
    --         "williamboman/mason.nvim",
    --         "williamboman/mason-lspconfig.nvim",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-cmdline",
    --         "hrsh7th/nvim-cmp",
    --         "L3MON4D3/LuaSnip",
    --         "saadparwaiz1/cmp_luasnip",
    --         "j-hui/fidget.nvim",
    --     },

    --     config = function()
    --         local cmp = require('cmp')
    --         local cmp_lsp = require("cmp_nvim_lsp")
    --         local capabilities = vim.tbl_deep_extend(
    --             "force",
    --             {},
    --             vim.lsp.protocol.make_client_capabilities(),
    --             cmp_lsp.default_capabilities())

    --         require("fidget").setup({})
    --         require("mason").setup()
    --         require("mason-lspconfig").setup({
    --             ensure_installed = {
    --                 "lua_ls",
    --                 "ts_ls",
    --             },
    --             handlers = {
    --                 function(server_name) -- default handler (optional)
    --                     require("lspconfig")[server_name].setup {
    --                         capabilities = capabilities
    --                     }
    --                 end,

    --                 ["lua_ls"] = function()
    --                     local lspconfig = require("lspconfig")
    --                     lspconfig.lua_ls.setup {
    --                         capabilities = capabilities,
    --                         settings = {
    --                             Lua = {
    --                                 diagnostics = {
    --                                     globals = { "vim", "it", "describe", "before_each", "after_each" },
    --                                 }
    --                             }
    --                         }
    --                     }
    --                 end,
    --             }
    --         })

    --         local cmp_select = { behavior = cmp.SelectBehavior.Select }

    --         cmp.setup({
    --             snippet = {
    --                 expand = function(args)
    --                     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --                 end,
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    --                 ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    --                 ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --             }),
    --             sources = cmp.config.sources({
    --                 { name = 'nvim_lsp' },
    --                 { name = 'luasnip' }, -- For luasnip users.
    --             }, {
    --                 { name = 'buffer' },
    --             })
    --         })

    --         vim.diagnostic.config({
    --             -- update_in_insert = true,
    --             float = {
    --                 focusable = false,
    --                 style = "minimal",
    --                 border = "rounded",
    --                 source = "always",
    --                 header = "",
    --                 prefix = "",
    --             },
    --         })
    --     end
    -- }
}
