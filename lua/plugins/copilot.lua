return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
		})
	end,
}

-- return { "github/copilot.vim" }

-- return {
-- 	"zbirenbaum/copilot.lua",
-- 	cmd = "Copilot",
-- 	event = "InsertEnter",
-- 	config = function()
-- 		require("copilot").setup({
-- 			suggestion = { enabled = false },
-- 			panel = { enabled = false },
-- 		})
-- 	end,
-- }
