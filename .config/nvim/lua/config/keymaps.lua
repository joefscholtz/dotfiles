-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- TODO: Add message when path is yanked
vim.keymap.set("n", "<leader>by", "<Cmd>let @+ = expand('%:p')<CR>", { desc = "Yank absolute buffer path" })
