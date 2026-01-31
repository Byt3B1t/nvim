return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.configs",
    branch = "master",
    opts = {
        ensure_installed = { "lua", "vim", "vimdoc", "python", "c", "markdown", "markdown_inline", "csv", "json", "yaml" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        additional_vim_regex_highlighting = false
    },
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
    end
}
