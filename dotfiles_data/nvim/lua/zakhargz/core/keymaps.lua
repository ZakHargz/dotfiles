vim.g.mapleader = " "

local keymap = vim.keymap
local opt = { noremap = true, silent = true, buffer = bufnr }
local builtin = require("telescope.builtin")

-- General Keymaps
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>sv", "<C-w>v") -- Split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- Split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- Make split window equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- Close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- Opens new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- Close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- Go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- Go to previous tab

keymap.set("", "<A-Down>", ":m .+1<CR>==", opt) -- Move line up
keymap.set("", "<A-Up>", ":m .-2<CR>==", opt) -- Move line down

keymap.set("n", "<C-s>", "<cmd> w <CR>")

-- Fast save, save quit, force exit
keymap.set("n", "<Leader>w", ":w!<CR>", { desc = "Write!" })
keymap.set("n", "<Leader>x", ":x<CR>", { desc = "Write and exit" })
keymap.set("n", "<Leader>qq", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<Leader>qa", ":qa!<CR>", { desc = "Quit all!" })
keymap.set("n", "<Leader>wq", ":wq!<CR>", { desc = "Write and quit!" })

-- Nvim-Tree
keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- Telescope
keymap.set("n", ";f", "<cmd>Telescope find_files<cr>")
keymap.set("n", ";fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", ";fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", ";b", "<cmd>Telescope buffers<cr>")
keymap.set("n", ";fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>ff", function()
	builtin.find_files()
end)
keymap.set("n", "gr", function()
	builtin.lsp_references()
end)

-- LSP
keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opt)
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opt)
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opt)
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt)
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt)
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opt)
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opt)
