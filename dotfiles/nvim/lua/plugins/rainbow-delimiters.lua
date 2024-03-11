return {
    "hiphish/rainbow-delimiters.nvim",
    {
        "andymass/vim-matchup",
        config = function()
            -- Plugin setup function
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
}
