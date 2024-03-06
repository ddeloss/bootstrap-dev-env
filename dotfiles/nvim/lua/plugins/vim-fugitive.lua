return {
  -- Plugin definition
  {
    "tpope/vim-fugitive",
    config = function()
      -- Import which-key
      local wk = require("which-key")

      -- Register key mappings for vim-fugitive commands
      wk.register({
        g = {
          name = "+git/Gen", -- Group name for git-related commands
          s = { "<cmd>Git<CR>", "Status" }, -- Open git status
          c = { "<cmd>Git commit<CR>", "Commit" }, -- Open commit window
          b = { "<cmd>Git blame<CR>", "Blame" }, -- Git blame for current file
          d = { "<cmd>Gvdiffsplit<CR>", "Diff" }, -- Open git diff for current file
          l = { "<cmd>Git log<CR>", "Log" }, -- View git log
          p = { "<cmd>Git push<CR>", "Push" }, -- Push changes
          P = { "<cmd>Git pull<CR>", "Pull" }, -- Pull changes
          -- Add more fugitive commands as needed
        },
      }, { prefix = "<leader>" })

      -- Additional setup can be added here if needed
    end,
  }
}
