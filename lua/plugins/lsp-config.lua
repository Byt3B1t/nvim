return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "jsonls", "taplo", "yamlls", "pylsp", "bashls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")


            lspconfig.pylsp.setup({
                capabilities = capabilities
            })
            lspconfig.bashls.setup({
                capabilities = capabilities
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities
            })
            lspconfig.taplo.setup({
                capabilities = capabilities
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    -- Local Mapping
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
                end,
            })
        end
    }
}
