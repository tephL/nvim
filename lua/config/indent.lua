local indent = {
  html = 2,
  css = 2,
  javascript = 2,
  typescript = 2,
  python = 4,
  c = 8,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(indent),
  callback = function(args)
    local width = indent[args.match]
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
  end,
})
