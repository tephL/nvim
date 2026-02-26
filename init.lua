-- disable netrw (nvim-tree replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.wo.number = true
vim.opt.termguicolors = true

-- vim-plug
vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'nvim-tree/nvim-tree.lua'

call plug#end()
]]

-- autocompletion
local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
    cmp.setup({
        snippet = { expand = function(args) end },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        })
    })
end

local capabilities = {}
if cmp_ok then
    capabilities = require('cmp_nvim_lsp').default_capabilities()
end

-- LSP
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    print("nvim-lspconfig not installed!")
    return
end

lspconfig.html.setup{
    cmd = { "node", "/data/data/com.termux/files/usr/lib/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_dir = function(fname) return vim.loop.cwd() end,
    capabilities = capabilities,
}

lspconfig.ts_ls.setup{
    cmd = {
        "node",
        "--experimental-specifier-resolution=node",
        "/data/data/com.termux/files/usr/lib/node_modules/typescript-language-server/lib/cli.mjs",
        "--stdio"
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = function(fname) return vim.loop.cwd() end,
    capabilities = capabilities,
}

lspconfig.pyright.setup{
    cmd = { "node", "/data/data/com.termux/files/usr/lib/node_modules/pyright/dist/pyright-langserver.js", "--stdio" },
    root_dir = function(fname) return vim.loop.cwd() end,
    capabilities = capabilities,
}

-- nvim-tree
local tree_ok, nvimtree = pcall(require, 'nvim-tree')
if tree_ok then
    nvimtree.setup({
        view = { width = 30 },
        renderer = {
            group_empty = true,
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = true,
                    git = false,
                },
            },
        },
        filters = { dotfiles = false },
    })
end

-- keybinds
vim.keymap.set('n', '1e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

