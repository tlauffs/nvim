local color_scheme_file = os.getenv("HOME") .. "/nix-dotfiles/home/current_theme.txt"
local color_scheme = "catppuccin" -- Default value

-- Check if the color scheme file exists
local file = io.open(color_scheme_file, "r")
if file then
	color_scheme = file:read("*line") or color_scheme -- Read the first line
	file:close()
end

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

-- Apply the colorscheme based on the text file
vim.defer_fn(function()
	if color_scheme == "catppuccin" then
		vim.cmd.colorscheme("catppuccin")
	elseif color_scheme == "gruvbox" then
		vim.cmd.colorscheme("gruvbox-baby")
	elseif color_scheme == "kanagawa" then
		vim.cmd.colorscheme("kanagawa")
	elseif color_scheme == "rose-pine" then
		vim.cmd.colorscheme("rose-pine")
	else
		print("Colorscheme '" .. color_scheme .. "' not found, using default 'catppuccin'.")
		vim.cmd.colorscheme("catppuccin") -- Fallback to the default scheme
	end
end, 0)

return plugins
