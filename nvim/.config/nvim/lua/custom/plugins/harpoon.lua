return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		local map = function(key, action)
			vim.keymap.set("n", key, action)
		end
		local harpoon = require("harpoon")
		harpoon:setup()

		-- append current file to harpoon list
		map("<leader>a", function()
			harpoon:list():add()
		end)

		-- toggle harpoon buffer
		map("<C-m>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- jump to specific entry by index
		map("<leader>1", function()
			harpoon:list():select(1)
		end)
		map("<leader>2", function()
			harpoon:list():select(2)
		end)
		map("<leader>3", function()
			harpoon:list():select(3)
		end)
		map("<leader>4", function()
			harpoon:list():select(4)
		end)

		-- toggle previous & next buffers stored within Harpoon list
		map("<leader>k", function()
			harpoon:list():prev()
		end)
		map("<leader>j", function()
			harpoon:list():next()
		end)

		-- telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			local dropdown = require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			})
			require("telescope.pickers")
				.new(
					{},
					vim.tbl_deep_extend("force", dropdown, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						sorter = conf.generic_sorter({}),
					})
				)
				:find()
		end

		-- fuzzy search harpoon entries
		vim.keymap.set("n", "<leader>st", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[s]earch harpoon [t]ags" })
	end,
}
