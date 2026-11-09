
function ColorMyPencils(color)
    color = color or "tokyonight-night"

    vim.cmd.colorscheme(color)

    -- Transparent background
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

-- Available themes
local themes = {
    "tokyonight-night",
    "catppuccin-mocha",
    "gruvbox",
    "rose-pine",
    "rose-pine-moon",
    "kanagawa",
    "nord",
    "nightfox",
    "everforest",
}

-- Theme selector
function ThemeSelector()
    vim.ui.select(themes, {
        prompt = "Select your colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            ColorMyPencils(choice)
            print("Colorscheme: " .. choice)
        end
    end)
end

return {
    -- TokyoNight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },

    -- Rose Pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            styles = {
                transparency = true,
            },
        },
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "mocha",
            transparent_background = true,
        },
    },

    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        opts = {
            transparent_mode = true,
        },
    },

    -- Kanagawa
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = true,
        },
    },

    -- Nord
    {
        "shaunsingh/nord.nvim",
    },

    -- Nightfox
    {
        "EdenEast/nightfox.nvim",
        opts = {
            options = {
                transparent = true,
            },
        },
    },

    -- Everforest
    {
        "sainnhe/everforest",
        init = function()
            vim.g.everforest_background = "hard"
            vim.g.everforest_transparent_background = 1
        end,
    },
}
