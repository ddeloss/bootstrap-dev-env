return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",
            ["a:"] = "@property.outer",
            ["i:"] = "@property.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["af"] = "@call.outer",
            ["if"] = "@call.inner",
            ["am"] = "@function.outer",
            ["im"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- Additional mappings can be added here following the same pattern.
          },
        },
        -- Other textobjects modules like swap, move can be configured here as well but are omitted for brevity.
      },
    })

    local wk = require("which-key")
    wk.register({
      ["a"] = {
        ["="] = { "<cmd>lua vim.notify('Select outer part of an assignment')<cr>", "Outer Assignment" },
        [":"] = { "<cmd>lua vim.notify('Select outer part of an object property')<cr>", "Outer Property" },
        ["a"] = { "<cmd>lua vim.notify('Select outer part of a parameter')<cr>", "Outer Parameter" },
        ["i"] = { "<cmd>lua vim.notify('Select outer part of a conditional')<cr>", "Outer Conditional" },
        ["l"] = { "<cmd>lua vim.notify('Select outer part of a loop')<cr>", "Outer Loop" },
        ["f"] = { "<cmd>lua vim.notify('Select outer part of a function call')<cr>", "Outer Function Call" },
        ["m"] = { "<cmd>lua vim.notify('Select outer part of a method/function definition')<cr>", "Outer Function" },
        ["c"] = { "<cmd>lua vim.notify('Select outer part of a class')<cr>", "Outer Class" },
      },
      ["i"] = {
        ["="] = { "<cmd>lua vim.notify('Select inner part of an assignment')<cr>", "Inner Assignment" },
        [":"] = { "<cmd>lua vim.notify('Select inner part of an object property')<cr>", "Inner Property" },
        ["a"] = { "<cmd>lua vim.notify('Select inner part of a parameter')<cr>", "Inner Parameter" },
        ["i"] = { "<cmd>lua vim.notify('Select inner part of a conditional')<cr>", "Inner Conditional" },
        ["l"] = { "<cmd>lua vim.notify('Select inner part of a loop')<cr>", "Inner Loop" },
        ["f"] = { "<cmd>lua vim.notify('Select inner part of a function call')<cr>", "Inner Function Call" },
        ["m"] = { "<cmd>lua vim.notify('Select inner part of a method/function definition')<cr>", "Inner Function" },
        ["c"] = { "<cmd>lua vim.notify('Select inner part of a class')<cr>", "Inner Class" },
      },
      -- Additional which-key mappings for other textobjects can be added here.
    }, { mode = "n" }) -- This ensures the mappings apply in normal mode.

    -- Note: The <cmd>lua vim.notify(...) part is just a placeholder to demonstrate.
    -- Replace it with actual Treesitter textobject commands or leave it as is for the notification.
  end,
}
