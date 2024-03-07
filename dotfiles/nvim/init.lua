-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local wk = require("which-key")
wk.register({
		D = {
				name = "+dap",
				b = {'<Cmd>lua require"dap".toggle_breakpoint()<CR>', "Toggle Breakpoint"},
				B = {'<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', "Set Conditional Breakpoint"},
				r = {'<Cmd>lua require"dap".repl.open()<CR>', "Open REPL"},
				l = {'<Cmd>lua require"dap".run_last()<CR>', "Run last"},
				n = {'<Cmd>lua require"dap-python".test_method()<CR>', "Python Test Method"},
				f = {'<Cmd>lua require"dap-python".test_class()<CR>', "Python Test Class"},
				s = {'<Cmd>lua require"dap-python".debug_selection()<CR>', "Python Debug Selection"},
		}
}, { prefix = "<leader>" })
