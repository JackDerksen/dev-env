return {
	"folke/which-key.nvim",
	lazy = true,
	event = "VeryLazy",
	opts = {
		-- Configuration here if I decide to change it in the future
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
