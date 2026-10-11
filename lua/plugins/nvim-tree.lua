return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>f", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in tree" },
  },
  opts = {
    view = {
      side = "left",
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local function folder_colors()
      vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#e5c07b" })
      vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#abb2bf" })
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#e5c07b", bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#5c6370" })
      vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#e5c07b", bold = true })
    end

    folder_colors()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = folder_colors })
  end,
}
