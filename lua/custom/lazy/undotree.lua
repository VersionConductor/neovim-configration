
return {
    {
        "mbbill/undotree",

        keys = {
            {
                "<leader>u",
                vim.cmd.UndotreeToggle,
                desc = "Undotree: Toggle",
            },
        },

        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffpanelHeight = 10
        end,
    },
}
