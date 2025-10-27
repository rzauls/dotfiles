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
				command = function(self, ctx)
					local vendor_pint = vim.fn.getcwd() .. "/vendor/bin/pint"
					if vim.fn.executable(vendor_pint) == 1 then
						return vendor_pint
					end

					local global_pint = vim.fn.expand("~/.composer/vendor/bin/pint")
					if vim.fn.executable(global_pint) == 1 then
						return global_pint
					end

					return "pint"
				end,
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
