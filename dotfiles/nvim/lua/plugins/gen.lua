return
{
    "David-Kunz/gen.nvim",
    opts = {
        model = "llama2:13b-chat", -- The default model to use.
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        display_mode = "split", -- The display mode. Can be "float" or "split".
        show_prompt = false, -- Shows the Prompt submitted to Ollama.
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = true, -- Never closes the window automatically.
        debug = false -- Prints errors and the command which is run.
    },
    config = function()
      require("which-key").setup({})

      -- Setting up the shortcut <leader>gg for Gen Ask
      local wk = require("which-key")
      wk.register({
        g = {
          name = "+git/Gen (LLM)", -- optional group name
          a = { "<cmd>Gen Ask<cr>", "Gen Ask" }, -- The actual command
        },
      }, { prefix = "<leader>" })
    end,
  }
