-- disable arrow keys
local keys = { "<Up>", "<Down>", "<Left>", "<Right>" }
for _, key in ipairs(keys) do
    vim.keymap.set({ "n", "v", "o" }, key, "<Nop>", { noremap = true, silent = true })
end

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true 

-- tab size 
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- colors
vim.opt.termguicolors = true

-- netrw keymap (disabled for file tree plugin)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = '1'
-- vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>', { desc = 'Open netrw' })

-- nvim tree remap 
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- buffer switching
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')
vim.opt.hidden = true

-- normal mode remap
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Bootstrap pckr
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"
  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
      "https://github.com/lewis6991/pckr.nvim", pckr_path })
  end
  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add({
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'L3MON4D3/LuaSnip',
    
  {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({
        sort     = { sorter = "case_sensitive" },
        view     = { width = 30 },
        renderer = { group_empty = true },
        filters  = { dotfiles = true },
      })
    end,
  },
  'mattn/emmet-vim',
  'hrsh7th/cmp-buffer', -- words from open buffers
  'hrsh7th/cmp-path',
})

-- Guard: only configure if plugins are installed
local ok, cmp = pcall(require, 'cmp')
if not ok then
  vim.notify("nvim-cmp not installed yet. Run :PckrInstall then restart.", vim.log.levels.WARN)
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>']     = cmp.mapping.select_next_item(),
    ['<S-Tab>']   = cmp.mapping.select_prev_item(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

lsp.intelephense.setup({ capabilities = capabilities })
lsp.html.setup({ capabilities = capabilities })
lsp.ts_ls.setup({ capabilities = capabilities })




-- random bs for front end go 
-- init.lua or lsp config file
require('lspconfig').cssls.setup({
  capabilities = capabilities  -- your existing nvim-cmp capabilities
})

require('lspconfig').html.setup({
  capabilities = capabilities
})

-- emmet
vim.g.user_emmet_leader_key = '<Tab>'
vim.g.user_emmet_install_global = 0

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'javascript' },
  command = 'EmmetInstall'
})

-- better cmp
require('cmp').setup({
  sources = {
    { name = 'nvim_lsp' },  -- you already have this
    { name = 'buffer' },    -- add
    { name = 'path' },      -- add
  }
})

-- filetypes 
vim.filetype.add({
  extension = {
    html = 'html',
    css  = 'css',
  }
})
