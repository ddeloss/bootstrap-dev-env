return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
        -- '.git',
        -- '.DS_Store',
        -- 'thumbs.db',
        },
        never_show = {},
      },
    }
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- Recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- Configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    })

    -- Set keymaps using which-key
    local wk = require("which-key")

    wk.register({
      e = {
        name = "+explorer", -- Group name for explorer related mappings
        e = { "<cmd>NvimTreeToggle<CR>", "Toggle file explorer" },
        f = { "<cmd>NvimTreeFindFileToggle<CR>", "Find file in explorer" },
        c = { "<cmd>NvimTreeCollapse<CR>", "Collapse explorer" },
        r = { "<cmd>NvimTreeRefresh<CR>", "Refresh explorer" },
      },
    }, { prefix = "<leader>" })
  end,
}
