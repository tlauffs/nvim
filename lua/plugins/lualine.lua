vim.pack.add { "https://github.com/nvim-tree/nvim-web-devicons" }
vim.pack.add { "https://github.com/nvim-lualine/lualine.nvim" }
require("lualine").setup {
	options = {
		theme = "auto",
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
}
