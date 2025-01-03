return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>t",
			function()
				require("neo-tree.command").execute({
					toggle = true,
					source = "filesystem",
				})
			end,
			desc = "Buffers (root dir)",
		},
	},
	opts = {
		close_if_last_window = true,
		window = {
			position = "right",
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
			follow_current_file = {
				enabled = true,
			},
		},
	},
}
