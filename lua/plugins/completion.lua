return {
  {
    "saghen/blink.cmp",
    version = "*", -- uses prebuilt binaries, no Rust needed
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" }, -- Ctrl-y accept, Ctrl-n/p select, Ctrl-e close
      sources = { 
	default = { "lsp", "path", "snippets", "buffer" },
	per_filetype = {
	  typescript = { "lsp", "snippets", "buffer" },
	  typescriptreact = { "lsp", "snippets", "buffer" },
	  javascript = { "lsp", "snippets", "buffer" },
	  javascriptreact = { "lsp", "snippets", "buffer" },
	},
      },
      completion = { documentation = { auto_show = true } },
      keymap = {
	  preset = "enter",
	  ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
	  ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "html", "cssls", "ts_ls", "emmet_language_server" },
      automatic_enable = true,
    },
  },
}
