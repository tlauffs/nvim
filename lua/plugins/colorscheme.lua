local gh = "https://github.com/"

vim.pack.add { gh .. "catppuccin/nvim" }
vim.pack.add { gh .. "luisiacc/gruvbox-baby" }
vim.pack.add { gh .. "rebelot/kanagawa.nvim" }
vim.pack.add { gh .. "rose-pine/neovim" }

local theme_file_path = os.getenv("HOME") .. "/.config/current_theme"
local current_theme_name = "rose-pine"

local file = io.open(theme_file_path, "r")
if file then
	current_theme_name = file:read("*a"):gsub("%s+", "")
	file:close()
end

local nvim_colorscheme_map = {
	["catppuccin"] = "catppuccin",
	["gruvbox"] = "gruvbox-baby",
	["kanagawa"] = "kanagawa",
	["rose-pine"] = "rose-pine",
	["rose-pine-dawn"] = "rose-pine-dawn",
	["digital-rain"] = "ron",
}

local nvim_colorscheme_to_load = nvim_colorscheme_map[current_theme_name] or "rose-pine"

vim.defer_fn(function()
	pcall(function() require("catppuccin").setup({ transparent_background = true }) end)
	vim.g.gruvbox_baby_transparent_mode = 1
	pcall(function() require("kanagawa").setup({ transparent = true }) end)
	pcall(function()
		require("rose-pine").setup({
			variant = "main",
			dark_variant = "main",
			styles = {
				transparency = true,
			},
		})
	end)

	local status_ok, err = pcall(vim.cmd, "colorscheme " .. nvim_colorscheme_to_load)
	if not status_ok then
		vim.notify(
			"Colorscheme " .. nvim_colorscheme_to_load .. " not found. Falling back to rose-pine. Error: " .. err,
			vim.log.levels.WARN
		)
		vim.cmd("colorscheme rose-pine")
	end
end, 0)
