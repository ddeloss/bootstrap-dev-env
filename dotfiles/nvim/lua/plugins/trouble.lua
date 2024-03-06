return {
  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" }, -- for icons
    config = function()
      require("trouble").setup({
        -- Your trouble.nvim configuration here
        -- For example:
        auto_open = true, -- Automatically open Trouble when an error is detected
        auto_close = true, -- Automatically close Trouble when it's the last window
        -- Refer to the trouble.nvim documentation for more configuration options
      })

      -- Optional: setting up keybindings with which-key.nvim
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          x = {
            name = "+trouble", -- Group name for Trouble commands
            x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
            l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
            q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
            -- Add more keybindings as needed
          },
        },
      })
    end,
  }
}
