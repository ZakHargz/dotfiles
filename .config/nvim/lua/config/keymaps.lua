local opts = { noremap = true, silent = true }

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')

-- Move to start/end of line
vim.keymap.set({ "n", "x", "o" }, "<A-Left>", "^", opts)
vim.keymap.set({ "n", "x", "o" }, "<A-Right>", "g_", opts)

-- Map enter to ciw in normal mode
vim.keymap.set("n", "<CR>", "ciw", opts)
vim.keymap.set("n", "<BS>", "ci", opts)

-- ctrl + x to cut full line
vim.keymap.set("n", "<C-x>", "dd", opts)

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", opts)

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- disable search highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", opts)
