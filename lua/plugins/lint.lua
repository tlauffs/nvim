vim.pack.add { "https://github.com/mfussenegger/nvim-lint" }
local lint = require("lint")

lint.linters.phpstan = {
	name = "phpstan",
	cmd = "vendor/bin/phpstan",
	stdin = false,
	args = {
		"analyse",
		"--error-format=raw",
		"--no-progress",
		"--level=9",
		"--memory-limit=512M",
		function()
			return vim.api.nvim_buf_get_name(0)
		end,
	},
	ignore_exitcode = true,
	parser = require("lint.parser").from_errorformat("%f:%l:%m", {
		source = "phpstan",
		severity = vim.diagnostic.severity.WARN,
	}),
}

lint.linters_by_ft = {
	php = { "phpstan" },
}

local function linter_cmd_exists(linter)
	local cmd = linter.cmd
	if type(cmd) == "function" then
		cmd = cmd()
	end
	if type(cmd) ~= "string" then
		return false
	end
	if cmd:find("/") then
		return vim.fn.findfile(cmd, vim.fn.expand("%:p:h") .. ";") ~= ""
	end
	return vim.fn.executable(cmd) == 1
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		if not vim.bo.modifiable then
			return
		end
		local linters = lint.linters_by_ft[vim.bo.filetype]
		if not linters then
			return
		end
		for _, name in ipairs(linters) do
			if not linter_cmd_exists(lint.linters[name]) then
				return
			end
		end
		lint.try_lint()
	end,
})
