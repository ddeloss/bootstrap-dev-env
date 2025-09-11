return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function()
            local logo = [[
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠶⠶⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠋⠀⠀⠀⠀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠁⢀⣐⣒⣒⣂⡀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣾⡿⠦⠟⠻⠶⢿⣷⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡹⣟⢷⡀⠀⠀⢀⡾⣻⢏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠙⠿⣦⡙⠷⠾⢋⣴⠿⠋⠳⣦⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢰⠇⢀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⡀⠸⡆⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⢀⡟⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢻⡀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠈⢷⣄⣸⣿⣿⣿⣿⣇⣸⣿⣿⣿⣿⣇⣠⡾⠁⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠿⠿⠿⠿⠿⠿⠿⠿⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    __/\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_
     _\/\\\////////\\\__\/\\\///////////__\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_
      _\/\\\______\//\\\_\/\\\_____________\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_
       _\/\\\_______\/\\\_\/\\\\\\\\\\\______\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_
        _\/\\\_______\/\\\_\/\\\///////________\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_
         _\/\\\_______\/\\\_\/\\\________________\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_
          _\/\\\_______/\\\__\/\\\_________________\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_
           _\/\\\\\\\\\\\\/___\/\\\\\\\\\\\\\\\______\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_
            _\////////////_____\///////////////________\///________\///////////__\///______________\///__
]]

            logo = string.rep("\n", 0) .. logo .. "\n"

            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
          -- stylua: ignore
            center = {
            {
                action = function() require("snacks").picker("files") end,
                desc = " Find file",
                icon = " ",
                key = "f",
            },
            {
                action = "ene | startinsert",
                desc = " New file",
                icon = " ",
                key = "n",
            },
            {
                action = function() require("snacks").picker("oldfiles") end,
                desc = " Recent files",
                icon = " ",
                key = "r",
            },
            {
                action = function() require("snacks").picker("live_grep") end,
                desc = " Find text",
                icon = " ",
                key = "g",
            },
            {
                action = function() require("snacks").picker("files", { cwd = vim.fn.stdpath("config") }) end,
                desc = " Config",
                icon = " ",
                key = "c",
            },
            {
                action = function() require("persistence").load() end,
                desc = " Restore Session",
                icon = " ",
                key = "s",
            },
            {
                action = "LazyExtras",
                desc = " Lazy Extras",
                icon = " ",
                key = "x",
            },
            {
                action = "Lazy",
                desc = " Lazy",
                icon = "󰒲 ",
                key = "l",
            },
            {
                action = "qa",
                desc = " Quit",
                icon = " ",
                key = "q",
            },
            },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return {
                            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
                        }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
}
