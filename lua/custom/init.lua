require("custom.remap")
require("custom.set")
require("custom.lazy_init")

-- vim.cmd([[colorscheme tokyonight]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local NvimEvent = augroup("NvimEventHub", { clear = true })
local yank_group = augroup("HighlightYank", { clear = true })

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

-- Highlight yanked text
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- Remove trailing whitespace before saving
autocmd("BufWritePre", {
    group = NvimEvent,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- LSP keybindings
autocmd("LspAttach", {
    group = NvimEvent,
    callback = function(e)
        local opts = { buffer = e.buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
})

-- Different colorschemes based on filetype
-- autocmd("FileType", {
--     group = NvimEvent,
--     callback = function(e)
--         if e.match == "zig" then
--             pcall(vim.cmd.colorscheme, "rose-pine-moon")
--         else
--             pcall(vim.cmd.colorscheme, "tokyonight-night")
--         end
--     end,
-- })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- ====== hide netrw dotfiles =========
-- vim.g.netrw_list_hide = '^\\..*$'
-- vim.g.netrw_hide = 1

