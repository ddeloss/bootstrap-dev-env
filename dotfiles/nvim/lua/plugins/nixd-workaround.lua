return {
    -- 1) Install the nixd binary via mason core (package name = "nixd")
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            if not vim.tbl_contains(opts.ensure_installed, "nixd") then
                table.insert(opts.ensure_installed, "nixd")
            end
        end,
    },

    -- 2) Do NOT ask mason-lspconfig to ensure nixd (it doesn't recognize it yet)
    {
        "mason-org/mason-lspconfig.nvim",
        opts = function(_, opts)
            -- remove nil_ls if some default added it
            local list = opts.ensure_installed or {}
            local filtered = {}
            for _, name in ipairs(list) do
                if name ~= "nil_ls" then
                    table.insert(filtered, name)
                end
            end
            opts.ensure_installed = filtered
        end,
    },

    -- 3) Configure lspconfig: enable nixd, disable nil_ls
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                nixd = {},
                nil_ls = false,
            },
            setup = {
                nil_ls = function()
                    return true
                end,
            },
        },
    },
}
