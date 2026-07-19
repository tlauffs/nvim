vim.pack.add { "https://github.com/folke/flash.nvim" }
require("flash").setup {}

vim.keymap.set({ "n", "x", "o" }, "<tab>", function()
	require("flash").jump()
end, { desc = "flash" })
vim.keymap.set({ "n", "x", "o" }, "<leader><tab>", function()
	require("flash").treesitter()
end, { desc = "flash treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "remote flash" })
vim.keymap.set({ "o", "x" }, "r", function()
	require("flash").treesitter_search()
end, { desc = "treesitter search" })
vim.keymap.set("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "toggle flash search" })
