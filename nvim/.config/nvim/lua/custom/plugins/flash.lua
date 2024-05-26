return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
  -- stylua: ignore
  keys = {
    { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash.nvim - [S]earch/jump" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "flash.nvim - cancel search" },
  },
}
