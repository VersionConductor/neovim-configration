return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
                popup_border_style = "rounded",
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = true,
                        hide_gitignored = true,
                    },
                    follow_current_file = {
                        enabled = true
                    },
                    use_libuv_file_watcher = true
                },
                window = {
                    position = "right",
                    width = 30
                },
            })
        end
    }
}
