return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function() -- Harpoon setup
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")
		harpoon:setup({})
		harpoon:extend(harpoon_extensions.highlight_current_file)

		vim.keymap.set("n", Leader .. "ha", function()
			harpoon:list():add()
		end, { desc = "Add Path" })
		vim.keymap.set("n", Leader .. "hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Menu" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<S-Tab>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<Tab>", function()
			harpoon:list():next()
		end)

		-- basic telescope configuration
		local theme = require("telescope.themes").get_dropdown({ previewer = true })
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new(
					{},
					vim.tbl_extend("force", theme, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
				)
				:find()
		end

		vim.keymap.set("n", Leader .. "ht", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Telescope" })
	end,
}
