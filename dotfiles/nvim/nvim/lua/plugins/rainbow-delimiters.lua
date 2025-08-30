return {
    "hiphish/rainbow-delimiters.nvim",
    "junegunn/fzf.vim",
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
}
