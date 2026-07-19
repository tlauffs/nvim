vim.loader.enable()

require("settings.options")
require("settings.keybinds")

local function gh(repo)
	return "https://github.com/" .. repo
end

local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			run_build(name, { "make" }, ev.data.path)
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

require("plugins.whichkey")
require("plugins.colorscheme")
require("plugins.mini")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.comment")
require("plugins.autoformat")
require("plugins.treesitter")
require("plugins.autocomplete")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.lint")
require("plugins.trouble")
require("plugins.neotree")
require("plugins.oil")
require("plugins.harpoon")
require("plugins.flash")
require("plugins.undo")
require("plugins.fugative")
require("plugins.vimtmuxnav")
require("plugins.todohighlights")
require("plugins.copilot")
