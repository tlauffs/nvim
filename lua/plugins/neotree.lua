vim.pack.add { "https://github.com/nvim-lua/plenary.nvim" }
vim.pack.add { "https://github.com/nvim-tree/nvim-web-devicons" }
vim.pack.add { "https://github.com/MunifTanjim/nui.nvim" }
vim.pack.add { "https://github.com/nvim-neo-tree/neo-tree.nvim" }
require("neo-tree").setup {
	close_if_last_window = true,
	window = {
		position = "right",
	},
	filesystem = {
		hijack_netrw_behavior = "disabled",
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		},
		follow_current_file = {
			enabled = true,
		},
	},
}

vim.keymap.set("n", "<leader>t", function()
	require("neo-tree.command").execute {
		toggle = true,
		source = "filesystem",
	}
end, { desc = "Buffers (root dir)" })
