return {
	{
		-- Git commands in nvim
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function()
			-- Fugitive key mappings
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
			vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", { desc = "Git pull" })
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
			vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
			vim.keymap.set("n", "<leader>gr", ":Gread<CR>", { desc = "Git read" })
			vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>", { desc = "Git write" })
		end,
	},
	{
		-- Git signs in the gutter
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Prev hunk" })

				-- Actions
				map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage selected hunk" })
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset selected hunk" })
				map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line" })
				map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
				map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, { desc = "Diff this ~" })
				map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		},
	},
	{
		-- Enhanced GitHub integration for fugitive
		"tpope/vim-rhubarb",
		event = "VeryLazy",
		dependencies = { "tpope/vim-fugitive" },
	},
	{
		-- Git browser
		"junegunn/gv.vim",
		event = "VeryLazy",
		dependencies = { "tpope/vim-fugitive" },
		config = function()
			vim.keymap.set("n", "<leader>gv", ":GV<CR>", { desc = "Git commit browser" })
			vim.keymap.set("n", "<leader>gvf", ":GV!<CR>", { desc = "Git file commit browser" })
		end,
	},
}
