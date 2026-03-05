--[[
installs:
vim-plug

lang:
sudo npm install -g vscode-langservers-extracted
sudo npm install -g typescript-language-server typescript
sudo pip install pyright --break-system-packages
]]


-- disable netrw for nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.wo.number = true
vim.opt.termguicolors = true

-- vimplug
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
    capabilities = capabilities,
}

lspconfig.ts_ls.setup{
    capabilities = capabilities,
}

lspconfig.pyright.setup{
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
