return {
	{ -- Various helper tools to extend lsp diagnostics with custom stuff
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- php
					-- null_ls.builtins.diagnostics.phpcs.with({
					-- 	extra_args = { "--standard=config/cs/ruleset.xml" },
					-- }),
					-- null_ls.builtins.diagnostics.phpstan,
					-- go
					null_ls.builtins.diagnostics.staticcheck,
				},
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
