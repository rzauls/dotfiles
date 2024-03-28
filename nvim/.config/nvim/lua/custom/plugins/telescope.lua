-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "benfowler/telescope-luasnip.nvim" },
	},
	config = function()
		local long_dropdown_theme = require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
			layout_config = {
				height = function(_, _, max_lines)
					return math.min(max_lines, 25)
				end,
			},
		})

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "luasnip")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = function(map, callback, opts)
			vim.keymap.set("n", map, callback, opts)
		end
		map("<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
		map("<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
		map("<leader>sf", function()
			builtin.find_files(vim.tbl_deep_extend("force", long_dropdown_theme, {
				hidden = true,
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			}))
		end, { desc = "[s]earch [f]iles" })
		map("<leader>ss", builtin.builtin, { desc = "[s]earch [s]elect Telescope" })
		map("<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
		map("<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
		map("<leader><leader>", builtin.live_grep, { desc = "[s]earch by [g]rep (alt keymap)" })
		map("<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
		map("<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
		map("<leader>s.", builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
		map("<leader>sl", require("telescope").extensions.luasnip.luasnip, { desc = "[s]earch [l]uaSnip snippets" })

		map("<leader>/", function()
			builtin.current_buffer_fuzzy_find(long_dropdown_theme)
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		map("<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[s]earch [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		map("<leader>sn", function()
			builtin.find_files(vim.tbl_deep_extend("keep", long_dropdown_theme, {
				prompt_title = "Find config file",
				hidden = true,
				cwd = vim.fn.stdpath("config"),
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			}))
		end, { desc = "[s]earch [n]eovim config files" })
	end,
}
