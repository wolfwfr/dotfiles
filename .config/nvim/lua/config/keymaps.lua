-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })

vim.keymap.set("n", "<leader>/", "<C-W>v", { desc = "Split Window Right", remap = true })

vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })

vim.keymap.set("n", "<leader>nn", "<cmd>AutoNote<CR>", { desc = "new daily note" })

vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<CR>")
