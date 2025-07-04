-- Read the current theme name from the file
local theme_file_path = os.getenv("HOME") .. "/.config/current_theme"
local current_theme_name = "rose-pine" -- Default theme if file not found or empty

local file = io.open(theme_file_path, "r")
if file then
	current_theme_name = file:read("*a"):gsub("%s+", "") -- Read and trim whitespace
	io.close(file)
end

-- Map theme names (from current_theme file) to Neovim colorscheme names (as installed)
-- IMPORTANT: Ensure the values on the RIGHT side of the = match the 'name' field
-- in your plugin definitions below, or the actual colorscheme name if different.
local nvim_colorscheme_map = {
	["catppuccin"] = "catppuccin",
	["gruvbox"] = "gruvbox-baby",
	["kanagawa"] = "kanagawa",
	["rose-pine"] = "rose-pine",
	["digital-rain"] = "ron",
}

-- Determine the colorscheme to load
local nvim_colorscheme_to_load = nvim_colorscheme_map[current_theme_name] or "rose-pine" -- Fallback if theme name not in map

local plugins = {
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({ transparent_background = true })
		end,
	},
	{
		"luisiacc/gruvbox-baby",
		name = "gruvbox-baby",
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_transparent_mode = 1
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				transparent = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				styles = {
					transparency = true,
				},
			})
		end,
	},
}

-- Apply the colorscheme based on the dynamically determined name
vim.defer_fn(function()
	local status_ok, err = pcall(vim.cmd, "colorscheme " .. nvim_colorscheme_to_load)
	if not status_ok then
		-- Use vim.notify for better user feedback if you have a notification plugin
		-- Otherwise, you can use print() or vim.api.nvim_echo()
		vim.notify(
			"Colorscheme " .. nvim_colorscheme_to_load .. " not found. Falling back to rose-pine. Error: " .. err,
			vim.log.levels.WARN
		)
		vim.cmd("colorscheme rose-pine") -- Fallback to the default scheme
	end
end, 0)

return plugins

