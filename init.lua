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

-- disable netrw (using nvim-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = '1'

-- nvim-tree toggle
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- buffer switching
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')
vim.keymap.set('n', '<leader>bad', ':bufdo bf<CR>')
vim.keymap.set('n', '<leader>db', ':%bd<CR>')
vim.opt.hidden = true

-- insert mode escape
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- emmet (use ,, instead of <Tab> to avoid conflict)
vim.g.user_emmet_leader_key = ','
vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'javascript' },
  command = 'EmmetInstall'
})

-- filetype detection
vim.filetype.add({
  extension = {
    html = 'html',
    css  = 'css',
  }
})

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
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'L3MON4D3/LuaSnip',
  'mattn/emmet-vim',
  'lukas-reineke/indent-blankline.nvim',
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
  'nvim-lua/plenary.nvim',
    {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git/" },
            },
        })
    end,
    },
})

-- Guard: only configure if plugins are installed
local ok, cmp = pcall(require, 'cmp')
if not ok then
  vim.notify("nvim-cmp not installed yet. Run :Pckr install then restart.", vim.log.levels.WARN)
  return
end

-- single cmp.setup()
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
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return { vim.api.nvim_get_current_buf() } -- current buffer only (saves RAM)
        end
      }
    },
    { name = 'path' },
  }),
})

-- single LSP setup block
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

lsp.intelephense.setup({ capabilities = capabilities })
lsp.ts_ls.setup({ capabilities = capabilities })
lsp.html.setup({ capabilities = capabilities })   -- once
lsp.cssls.setup({ capabilities = capabilities })  -- once

-- indent line
local ok_ibl, ibl = pcall(require, 'ibl')
if ok_ibl then
  ibl.setup()
end

-- ffinder 
local ok_tel, tel = pcall(require, 'telescope.builtin')
if ok_tel then
    vim.keymap.set('n', '<leader>ff', tel.find_files,  { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', tel.live_grep,   { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fb', tel.buffers,     { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', tel.help_tags,   { desc = 'Help tags' })
end

-- filetype for jsx 
vim.filetype.add({
    extension = {
        jsx = "javascriptreact",
    }, 
});

vim.g.user_emmet_settings = {
  javascriptreact = {
    extends = "jsx",
  },
}

vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascriptreact" },
  callback = function()
    vim.cmd("EmmetInstall")
  end,
})
