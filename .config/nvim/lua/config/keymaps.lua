-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- TODO: Add message when path is yanked
local keymap = vim.keymap.set

keymap("n", "<leader>by", "<Cmd>let @+ = expand('%:p')<CR>", { desc = "Yank absolute buffer path" })

-- 1. Make d, c, x use the black hole register ("_") by default
-- This stops them from overwriting your yank buffer
keymap({ "n", "v" }, "d", '"_d', { desc = "Delete (black hole)" })
keymap({ "n", "v" }, "c", '"_c', { desc = "Change (black hole)" })
keymap({ "n", "v" }, "x", '"_x', { desc = "Delete char (black hole)" })

-- Also map the uppercase variants
keymap("n", "D", '"_D', { desc = "Delete to EOL (black hole)" })
keymap("n", "C", '"_C', { desc = "Change to EOL (black hole)" })
keymap("n", "X", '"_X', { desc = "Delete char back (black hole)" })

-- 2. Map _d, _c, _x to the *original* behavior
-- This makes them explicitly use the unnamed register ("") to save the text
keymap({ "n", "v" }, "_d", '""d', { desc = "Delete (to yank buffer)" })
keymap({ "n", "v" }, "_c", '""c', { desc = "Change (to yank buffer)" })
keymap({ "n", "v" }, "_x", '""x', { desc = "Delete char (to yank buffer)" })

-- You can also add uppercase variants if you use them
keymap("n", "_D", '""D', { desc = "Delete to EOL (to yank buffer)" })
keymap("n", "_C", '""C', { desc = "Change to EOL (to yank buffer)" })
keymap("n", "_X", '""X', { desc = "Delete char back (to yank buffer)" })
