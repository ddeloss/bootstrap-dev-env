return {
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("trouble").setup({ auto_open = false, auto_close = true })
            local wk = require("which-key")
            wk.add({
                { "<leader>x", group = "trouble" },
                { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble", mode = "n" },
                { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics", mode = "n" },
                { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics", mode = "n" },
                { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Loclist", mode = "n" },
                { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "QuickFix", mode = "n" },
                { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References", mode = "n" },
            })
        end,
    },
}
