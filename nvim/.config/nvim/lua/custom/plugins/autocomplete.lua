-- Autocompletion
return {
	-- we try out blink.cmp for now

	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "v0.6.2",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- see the "default configuration" section below for full documentation on how to define
		-- your own keymap.
		keymap = { preset = "default" },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, via `opts_extend`
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer" },
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
			},
		},

		-- experimental auto-brackets support
		-- completion = { accept = { auto_brackets = { enabled = true } } }

		-- experimental signature help support
		-- signature = { enabled = true }
	},
	-- allows extending the enabled_providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.completion.enabled_providers" },
	signature = {
		enabled = true,
		trigger = {
			show_on_insert_or_trigger_character = true,
		},
	},
	completion = {
		documentation = {
			-- Controls whether the documentation window will automatically show when selecting a completion item
			auto_show = true,
			-- Delay before showing the documentation window
			auto_show_delay_ms = 100,
			-- Delay before updating the documentation window when selecting a new item,
			-- while an existing item is still visible
			update_delay_ms = 50,
			-- Whether to use treesitter highlighting, disable if you run into performance issues
			treesitter_highlighting = true,
			window = {
				min_width = 10,
				max_width = 60,
				max_height = 20,
				border = "padded",
				winblend = 0,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- Note that the gutter will be disabled when border ~= 'none'
				scrollbar = true,
				-- Which directions to show the documentation window,
				-- for each of the possible menu window directions,
				-- falling back to the next direction when there's not enough space
				direction_priority = {
					menu_north = { "e", "w", "n", "s" },
					menu_south = { "e", "w", "s", "n" },
				},
			},
		},
	},
}
