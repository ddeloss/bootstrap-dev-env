return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>h", group = "harpoon" },
            { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Mark file with harpoon", mode = "n" },
            { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Go to next harpoon mark", mode = "n" },
            { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Go to previous harpoon mark", mode = "n" },
        })
    end,
}
