return {
	{
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = function()
				return { mode = "cursor", max_lines = 3 }
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			}
			sync_install = false
			auto_install = true
			indent = { enable = true }
			highlight = { enable = true }
		end,
	},
}
