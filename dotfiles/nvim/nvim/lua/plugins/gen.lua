return {
    "David-Kunz/gen.nvim",
    opts = {
        model = "llama2:13b-chat",
        host = "localhost",
        port = "11434",
        display_mode = "split",
        show_prompt = false,
        show_model = true,
        no_auto_close = true,
        debug = false,
    },
    config = function()
        require("which-key").setup({})

        local wk = require("which-key")
        wk.add({
            { "<leader>g", group = "git/Gen (LLM)" },
            { "<leader>ga", "<cmd>Gen Ask<cr>", desc = "Gen Ask", mode = "n" },
        })
    end,
}
