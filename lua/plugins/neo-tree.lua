return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                commands = {
                    -- Override delete to use trash instead of rm
                    delete = function(state)
                        local inputs = require "neo-tree.ui.inputs"
                        local path = state.tree:get_node().path
                        local msg = "Are you sure you want to delete " .. path
                        inputs.confirm(msg, function(confirmed)
                            if not confirmed then return end

                            vim.fn.system { "trash", vim.fn.fnameescape(path) }
                            require("neo-tree.sources.manager").refresh(state.name)
                        end)
                    end,
                },
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                }
            }
        })
        vim.keymap.set("n", "<leader>qq", vim.cmd.Neotree)
    end
}
