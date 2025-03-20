require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move line up
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Move line down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
