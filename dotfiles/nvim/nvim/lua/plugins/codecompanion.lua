return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
	config = function()
		require("codecompanion").setup({
		  adapters = {
		    deepseek = function()
		      require("codecompanion.adapters").extend("ollama", {
		        env = {
		          url = "127.0.0.1:11434", -- optional: default value is ollama url http://127.0.0.1:11434
		          chat_url = "/v1/chat/completions", -- optional: default value, override if different
		          models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
		        },
		        schema = {
		          model = {
		            default = "deepseek-coder-v2:16b-lite-instruct-q5_1",  -- define llm model to be used
		          }
	          }
						})
		    end,
				qwen = function()
		      require("codecompanion.adapters").extend("ollama", {
		        env = {
		          url = "127.0.0.1:11434", -- optional: default value is ollama url http://127.0.0.1:11434
		          models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
		        },
		        schema = {
		          model = {
		            default = "qwen2",  -- define llm model to be used
		          }
		          },
		      })
		    end,
		  },
			strategies = {
				chat = {
					adapter = deepseek,
				},
				inline = {
					adapter = qwen,
				},
			},
		})
	end,
}
