return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- Load LazyVim utilities
			local utils = require("utils")
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Setup highlight group for ghost text
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			-- Configuration options
			local auto_select = true
			local auto_brackets = { "python" } -- filetypes to auto-add brackets for function calls

			cmp.setup({
				auto_brackets = auto_brackets,
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = utils.cmp.confirm({ select = auto_select }),
					["<C-y>"] = utils.cmp.confirm({ select = true }),
					["<S-CR>"] = utils.cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<Tab>"] = cmp.mapping(function(fallback)
						utils.cmp.map({ "snippet_forward" }, fallback)()
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						utils.cmp.map({ "snippet_backward" }, fallback)()
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(entry, item)
						-- Limit the width of completion items for better UI
						local widths = {
							abbr = 40, -- max width of item text
							menu = 30, -- max width of details/source
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},
				experimental = {
					ghost_text = { hl_group = "CmpGhostText" },
				},
			})

			-- Set up auto_brackets behavior
			cmp.event:on("confirm_done", function(event)
				local ft = vim.bo.filetype
				if vim.tbl_contains(auto_brackets, ft) then
					utils.cmp.auto_brackets(event.entry)
				end
			end)

			-- Add documentation for snippets
			cmp.event:on("menu_opened", function(event)
				utils.cmp.add_missing_snippet_docs(event.window)
			end)

			-- Add ESC handling for snippet mode
			vim.keymap.set({ "i", "s" }, "<Esc>", function()
				if luasnip.session and luasnip.session.current_nodes then
					if not luasnip.session.jump_active then
						luasnip.unlink_current()
					end
				end
				return "<Esc>"
			end, { expr = true })
		end,
	},
}
