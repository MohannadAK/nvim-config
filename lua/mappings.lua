require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Move line up
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- Move line down (optional, for completeness)
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
