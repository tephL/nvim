return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- compatible with Neovim 0.11
  build = ":TSUpdate",
  lazy = false,
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "bash",
      "json",
      "python",
    },
    highlight = {
      enable = true,
    },
  },
}
