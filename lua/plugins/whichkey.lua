return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>x", group = "[X]trouble" },
			{ "<leader>c_", desc = "<leader>c_", hidden = true },
			{ "<leader>r_", desc = "<leader>r_", hidden = true },
			{ "<leader>s_", desc = "<leader>s_", hidden = true },
			{ "<leader>w_", desc = "<leader>w_", hidden = true },
			{ "<leader>x_", desc = "<leader>x_", hidden = true },
		})
	end,
}
