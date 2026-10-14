-- floating errors 
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "#ff6b6b" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff6b6b" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff6b6b" })
