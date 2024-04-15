return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		require("orgmode").setup({
			org_agenda_files = "~/orgfiles/**/*",
			-- TODO: add env value for this maybe?
			org_default_notes_file = "~/orgfiles/refile.org",
		})

		-- TODO: keymaps
		-- TODO: more capture templates
	end,
}
