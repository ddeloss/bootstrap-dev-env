return {
    -- nvim-dap installation and configuration
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')

            -- Automatically open and close the DAP UI with debugging events
            dap.listeners.after.event_initialized["dapui_config"] = function()
                require("dapui").open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                require("dapui").close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                require("dapui").close()
            end

            -- Sign definitions for DAP
            vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='', numhl=''})
        end
    },
    -- nvim-dap-python installation and configuration
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        end
    },
    -- nvim-dap-ui installation and configuration
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require('dapui').setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    expand = {"<CR>", "<2-LeftMouse>"},
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
            })
        end
    },
  }
