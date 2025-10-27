-- Autoformat
return {
	"stevearc/conform.nvim",
	event = "InsertEnter",
	opts = {
		notify_on_error = false,
		format_on_save = require("custom.util").should_format_on_save() and {
			timeout_ms = 500,
			lsp_fallback = true,
		} or false,
		formatters = {
			typespec = {
				command = "tsp",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
			pint = {
				command = "vendor/bin/pint",
				args = { "$FILENAME" },
				stdin = false,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			xml = { "xmlformat" },
			sql = { "sql_formatter" },
			gohtmltmpl = { "prettier" },
			php = { "pint" },
		},
	},
}
