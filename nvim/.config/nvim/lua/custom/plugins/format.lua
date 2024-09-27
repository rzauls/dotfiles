-- Autoformat
return {
	"stevearc/conform.nvim",
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
			typespec = { "typespec" },
			sql = { "sql_formatter" },
			gohtmltmpl = { "prettier" },
		},
	},
}
