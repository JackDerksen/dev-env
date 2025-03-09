return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = function()
			return { mode = "cursor", max_lines = 3 }
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"rust",
					"python",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = true,
				indent = { enable = true },
				highlight = { enable = true },
			})
		end,
	},
}
