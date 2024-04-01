return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		-- NOTE: this is how you would pass connection strings to the UI
		-- vim.g.dbs = {
		-- 	dev = "postgres://postgres:mypassword@localhost:5432/my-dev-db",
		-- 	staging = "postgres://postgres:mypassword@localhost:5432/my-staging-db",
		-- 	wp = "mysql://root@localhost/wp_awesome",
		-- }
	end,
}
