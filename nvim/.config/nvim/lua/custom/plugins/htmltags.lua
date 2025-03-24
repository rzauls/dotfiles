return {
	"windwp/nvim-ts-autotag",
	event = "VeryLazy",
	config = function()
		require("nvim-ts-autotag").setup({
			filetypes = {
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"tsx",
				"jsx",
				"rescript",
				"xml",
				"php",
				"markdown",
				"astro",
				"glimmer",
				"handlebars",
				"hbs",
				"templ", -- templ is the only non-default one
			},
		})
	end,
}
