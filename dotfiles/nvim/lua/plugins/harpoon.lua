return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Import which-key
    local wk = require("which-key")

    -- Define the keymaps using which-key's register function
    wk.register({
      h = {
        name = "+harpoon", -- Group name for harpoon related mappings
        m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Mark file with harpoon" },
        n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Go to next harpoon mark" },
        p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Go to previous harpoon mark" },
      },
    }, { prefix = "<leader>" })
  end,
}
