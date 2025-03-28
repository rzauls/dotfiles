-- Autoformat
return {
	"stevearc/conform.nvim",
	event = "InsertEnter",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters = {
			typespec = {
				command = "tsp",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			xml = { "xmlformat" },
			sql = { "sql_formatter" },
			gohtmltmpl = { "prettier" },
		},
	},
}
