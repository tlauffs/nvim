vim.pack.add { "https://github.com/stevearc/conform.nvim" }
require("conform").setup {
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		return {
			timeout_ms = 500,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = {
			formatters = { "prettierd", "prettier" },
			stop_after_first = true,
		},
		php = { "php-cs-fixer" },
		json = {
			"prettierd",
			"prettier",
			stop_after_first = true,
		},
	},
	formatters = {
		["php-cs-fixer"] = {
			command = "php-cs-fixer",
			args = {
				"fix",
				"--rules=@PSR12",
				"$FILENAME",
			},
			stdin = false,
		},
	},
}

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format { async = true, lsp_fallback = true }
end, { desc = "[F]ormat buffer" })
