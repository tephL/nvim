vim.g.mapleader = "1"
vim.keymap.set("i", "jk", "<Esc>")

-- buffer 
-- vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")
-- vim.keymap.set("n", "<Tab>", ":bprev<CR>")
vim.keymap.set("n", "<leader>bd", ":bdel<CR>")
vim.keymap.set("n", "<leader>db", ":%bd<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
