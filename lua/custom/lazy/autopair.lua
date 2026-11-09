
return {
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter" },

        branch = "v0.6",

        opts = {
            -- Enable automatic pairing
            fastwarp = {
                enable = true,
            },

            -- Disable pairing in certain contexts if needed
            extensions = {
                filetype = {
                    ts = {
                        "typescript",
                    },
                },
            },
        },
    },
}

