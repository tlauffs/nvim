vim.pack.add { "https://github.com/nvim-lua/plenary.nvim" }
vim.pack.add { { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" } }
local harpoon = require("harpoon")
harpoon:setup {}

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end
	require("telescope.pickers")
		.new({}, {
		prompt_title = "Harpoon",
		finder = require("telescope.finders").new_table {
			results = file_paths,
		},
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	})
	:find()
end

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "harpoon add" })
vim.keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon menu" })
vim.keymap.set("n", "<leader>sp", function()
	toggle_telescope(harpoon:list())
end, { desc = "[S]earch har[P]oon" })
for i = 1, 7 do
	vim.keymap.set("n", "g" .. i, function()
		harpoon:list():select(i)
	end, { desc = "harpoon jump " .. i })
end
