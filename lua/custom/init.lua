require("custom.remap")
require("custom.set")
require("custom.lazy_init")

-- vim.cmd([[colorscheme tokyonight]])

local augroup = vim.api.nvim_create_augroup
local TheCustomGroup = augroup('TheCustom', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})


autocmd({"BufWritePre"}, {
    group = TheCustomGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- ====== hide netrw dotfiles =========
-- vim.g.netrw_list_hide = '^\\..*$'
-- vim.g.netrw_hide = 1

