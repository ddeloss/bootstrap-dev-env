-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local wk = require("which-key")
wk.add({
    { "<leader>D", group = "dap" },
    { "<leader>Db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint", mode = "n" },
    { "<leader>DB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Set Conditional Breakpoint", mode = "n" },
    { "<leader>Dr", "<Cmd>lua require'dap'.repl.open()<CR>", desc = "Open REPL", mode = "n" },
    { "<leader>Dl", "<Cmd>lua require'dap'.run_last()<CR>", desc = "Run last", mode = "n" },
    { "<leader>Dn", "<Cmd>lua require'dap-python'.test_method()<CR>", desc = "Python Test Method", mode = "n" },
    { "<leader>Df", "<Cmd>lua require'dap-python'.test_class()<CR>", desc = "Python Test Class", mode = "n" },
    { "<leader>Ds", "<Cmd>lua require'dap-python'.debug_selection()<CR>", desc = "Python Debug Selection", mode = "n" },
})
