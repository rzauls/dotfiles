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
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local trouble = require("trouble.sources.telescope")

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"rg",
						"-uu",
						"--files",
						"--hidden",
						"--glob",
						"!{**/node_modules/*,**/.git/*,**/.venv/*,**/.zig-cache/*}",
					},
				},
			},
			defaults = {
				mappings = {
					i = { ["<c-t>"] = trouble.open },
					n = { ["<c-t>"] = trouble.open },
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = function(map, callback, opts)
			vim.keymap.set("n", map, callback, opts)
		end
		map("<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
		map("<leader>sc", builtin.commands, { desc = "[s]earch [c]ommands" })
		map("<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
		map("<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
		map("<leader>ss", builtin.builtin, { desc = "[s]earch [s]elect Telescope" })
		map("<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
		map("<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
		map("<leader><leader>", builtin.live_grep, { desc = "[s]earch by [g]rep (alt keymap)" })
		map("<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
		map("<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
		map("<leader>s.", builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
		map("<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		map("<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[s]earch [/] in Open Files" })

		-- Shortcut for searching dotfiles files
		map("<leader>sn", function()
			local find_config_opts = {
				prompt_title = "Find config file",
				hidden = true,
				cwd = os.getenv("DOTFILES_PATH"),
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			}
			if os.getenv("DOTFILES_PATH") == nil then
				find_config_opts.cwd = vim.fn.stdpath("config")
			end
			builtin.find_files(find_config_opts)
		end, { desc = "[s]earch [n]eovim and user config files" })
	end,
}
