return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
        local catppuccin = require("catppuccin")

        catppuccin.setup({
            transparent_background = true
        })

        vim.cmd('colorscheme catppuccin')
    end
}
