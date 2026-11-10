
return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary",
    },

    {
        "github/copilot.vim",
        event = "InsertEnter",
    },

    {
        "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },

    {
        "gpanders/editorconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
}
