return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- Import lspconfig and cmp_nvim_lsp plugins
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local wk = require("which-key")

    local on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      -- Define LSP keymaps with descriptions using which-key
      wk.register({
        g = {
          name = "+goto", -- Group name for goto commands
          R = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
          D = { vim.lsp.buf.declaration, "Go to declaration" },
          d = { "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
          i = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
          t = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
        },
        ["<leader>"] = {
          c = {
            name = "+code", -- Group name for code actions
            a = { vim.lsp.buf.code_action, "See available code actions" },
          },
          r = {
            n = { vim.lsp.buf.rename, "Smart rename" },
          },
          D = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
          d = { vim.diagnostic.open_float, "Show line diagnostics" },
          rs = { "<cmd>LspRestart<CR>", "Restart LSP" },
        },
        ["["] = {
          d = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
        },
        ["]"] = {
          d = { vim.diagnostic.goto_next, "Go to next diagnostic" },
        },
        K = { vim.lsp.buf.hover, "Show documentation for what is under cursor" },
      }, bufopts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Diagnostic symbols customization
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- LSP servers setup
    local servers = { "html", "tsserver", "cssls", "tailwindcss", "pyright", "terraformls", "sqlls", "marksman", "autotools_ls", "jsonls", "gopls", "rust_analyzer", "csharp_ls", "bashls", "lua_ls" }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = lsp == "lua_ls" and {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        } or nil -- Only special settings for lua_ls
      })
    end
  end,
}
