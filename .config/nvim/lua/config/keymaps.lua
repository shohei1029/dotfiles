-- キーマップ（旧 init.vim の map 群を移植）
local map = vim.keymap.set

-- 挿入モードで jj を Esc に
map("i", "jj", "<Esc>", { desc = "Escape" })

-- Esc 二回でハイライト解除
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- 表示行単位で行移動する
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

-- 挿入モードでのカーソル移動
map("i", "<C-d>", "<Delete>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

-- neo-tree（ファイルツリー）トグル。旧 NERDTree の代替
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Toggle file tree" })
