return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
			--"permissions",
			"size",
			-- "mtime",
		},
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		win_options = {
			wrap = false,
			signcolumn = "yes",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		delete_to_trash = false,
		skip_confirm_for_simple_edits = true,
		prompt_save_on_select_new_entry = true,
		cleanup_delay_ms = 2000,
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
		},
		-- Set to false to disable all of the above keymaps
		use_default_keymaps = false,
		view_options = {
			show_hidden = true,
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end,
			is_always_hidden = function(name, bufnr)
				return false
			end,
			sort = {
				{ "type", "asc" },
				{ "name", "asc" },
			},
			render = {
				icon = {
					directory = "󰉋",
					renderer = function(icon_str, metadata, render_opts)
						local icon, hl = require("nvim-web-devicons").get_icon(
							metadata.name,
							vim.fn.fnamemodify(metadata.name, ":e"),
							{ default = true }
						)
						-- Override the highlight group to make it colorless
						return icon, "Normal"
					end,
				},
			},
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			padding = 5,
			max_width = 48,
			max_height = 12,
			win_options = {
				winblend = 0,
				winhl = "Normal:Normal,Float:Float",
			},
			override = function(conf)
				return conf
			end,
		},
		-- Configuration for the actions floating preview window
		preview = {
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
			max_width = 0.9,
			-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
			min_width = { 40, 0.4 },
			-- optionally define an integer/float for the exact width of the preview window
			width = nil,
			-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_height and max_height can be a single value or a list of mixed integer/float types.
			-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
			max_height = 0.9,
			-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
			min_height = { 5, 0.1 },
			-- optionally define an integer/float for the exact height of the preview window
			height = nil,
			--border = "rounded",
			win_options = {
				winblend = 0,
				winhl = "Normal:Normal,Float:Float",
			},
		},
		-- Configuration for the floating progress window
		progress = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			width = nil,
			max_height = { 10, 0.9 },
			min_height = { 5, 0.1 },
			height = nil,
			--border = "rounded",
			minimized_border = "none",
			win_options = {
				winblend = 0,
				winhl = "Normal:Normal,Float:Float",
			},
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
				color_icons = false,
				override = {
					default_icon = {
						color = "#e2e2e3",
						name = "Default",
					},
				},
			})
		end,
	},
}
