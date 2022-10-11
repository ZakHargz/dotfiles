local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move lines up and down
keymap("", "<A-Down>", ":m .+1<CR>==", opts)
keymap("", "<A-Up>", ":m .-2<CR>==", opts)

-- Toggle tree
keymap("n", "<C-e>", "<cmd>lua require'nvim-tree'.toggle()<CR>", opts)

-- FZF
keymap("n", "<leader><leader>", ":GFiles!<CR>", opts)
keymap("n", "<leader>ff", ":Files!<CR>", opts)
keymap("n", "<leader>/", ":Rg!<CR>", opts)
keymap("n", "<leader>bb", ":Buffers!<CR>", opts)
