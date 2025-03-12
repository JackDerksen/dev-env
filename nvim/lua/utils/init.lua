-- Code to emulate LazyVim's completion
local M = {}

-- Add the cmp utilities
M.cmp = {}

-- Snippet action functions
---@type table<string, function>
M.cmp.actions = {
	-- Native Snippets
	snippet_forward = function()
		if vim.snippet and vim.snippet.active({ direction = 1 }) then
			vim.schedule(function()
				vim.snippet.jump(1)
			end)
			return true
		end

		-- LuaSnip compatibility
		local has_luasnip, luasnip = pcall(require, "luasnip")
		if has_luasnip and luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
			return true
		end
	end,

	snippet_backward = function()
		if vim.snippet and vim.snippet.active({ direction = -1 }) then
			vim.schedule(function()
				vim.snippet.jump(-1)
			end)
			return true
		end

		-- LuaSnip compatibility
		local has_luasnip, luasnip = pcall(require, "luasnip")
		if has_luasnip and luasnip.jumpable(-1) then
			luasnip.jump(-1)
			return true
		end
	end,

	snippet_stop = function()
		if vim.snippet then
			vim.snippet.stop()
			return true
		end

		-- LuaSnip compatibility
		local has_luasnip, luasnip = pcall(require, "luasnip")
		if has_luasnip and luasnip.session and luasnip.session.current_nodes then
			luasnip.unlink_current()
			return true
		end
	end,
}

---@param actions string[]
---@param fallback? string|fun()
function M.cmp.map(actions, fallback)
	return function()
		for _, name in ipairs(actions) do
			if M.cmp.actions[name] then
				local ret = M.cmp.actions[name]()
				if ret then
					return true
				end
			end
		end
		return type(fallback) == "function" and fallback() or fallback
	end
end

---@alias Placeholder {n:number, text:string}

---@param snippet string
---@param fn fun(placeholder:Placeholder):string
---@return string
function M.cmp.snippet_replace(snippet, fn)
	return snippet:gsub("%$%b{}", function(m)
		local n, name = m:match("^%${(%d+):(.+)}$")
		return n and fn({ n = n, text = name }) or m
	end) or snippet
end

-- This function resolves nested placeholders in a snippet.
---@param snippet string
---@return string
function M.cmp.snippet_preview(snippet)
	local ok, parsed = pcall(function()
		return vim.lsp._snippet_grammar.parse(snippet)
	end)
	return ok and tostring(parsed)
		or M.cmp
			.snippet_replace(snippet, function(placeholder)
				return M.cmp.snippet_preview(placeholder.text)
			end)
			:gsub("%$0", "")
end

-- This function replaces nested placeholders in a snippet with LSP placeholders.
function M.cmp.snippet_fix(snippet)
	local texts = {} ---@type table<number, string>
	return M.cmp.snippet_replace(snippet, function(placeholder)
		texts[placeholder.n] = texts[placeholder.n] or M.cmp.snippet_preview(placeholder.text)
		return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
	end)
end

-- Add auto brackets for function and method completions
---@param entry table
function M.cmp.auto_brackets(entry)
	local cmp = require("cmp")
	local item = entry:get_completion_item()
	local kind = item.kind

	-- Check if it's a function or method (kind numbers 3 and 2 in LSP)
	if kind == 3 or kind == 2 then -- Function or Method
		local cursor = vim.api.nvim_win_get_cursor(0)
		local line = vim.api.nvim_get_current_line()
		local col = cursor[2]
		local char_after = line:sub(col + 1, col + 1)

		if char_after ~= "(" and char_after ~= ")" then
			local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
			vim.api.nvim_feedkeys(keys, "i", true)
		end
	end
end

-- Create an undo point
function M.create_undo()
	local keys = vim.api.nvim_replace_termcodes("<C-g>u", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

-- This is a better implementation of `cmp.confirm`
---@param opts? table
function M.cmp.confirm(opts)
	local cmp = require("cmp")
	opts = vim.tbl_extend("force", {
		select = true,
		-- Use Insert behavior by default (can be Insert or Replace)
		behavior = cmp.ConfirmBehavior and cmp.ConfirmBehavior.Insert or 1,
	}, opts or {})

	return function(fallback)
		if cmp.visible() or vim.fn.pumvisible() == 1 then
			M.create_undo()
			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

function M.cmp.expand(snippet)
	-- Native sessions don't support nested snippet sessions.
	-- Always use the top-level session.
	local session = vim.snippet and vim.snippet.active() and vim.snippet._session or nil

	local ok, err = pcall(vim.snippet.expand, snippet)
	if not ok then
		local fixed = M.cmp.snippet_fix(snippet)
		ok = pcall(vim.snippet.expand, fixed)

		local msg = ok and "Failed to parse snippet,\nbut was able to fix it automatically."
			or ("Failed to parse snippet.\n" .. err)

		vim.notify(msg, ok and vim.log.levels.WARN or vim.log.levels.ERROR)
	end

	-- Restore top-level session when needed
	if session then
		vim.snippet._session = session
	end
end

-- Add missing documentation to snippets
---@param window table
function M.cmp.add_missing_snippet_docs(window)
	local cmp = require("cmp")
	-- Get entries from the window if the method exists
	local entries = window.get_entries and window:get_entries() or {}

	for _, entry in ipairs(entries) do
		-- Check if it's a snippet entry (kind number 15 in LSP)
		if entry.get_kind and entry:get_kind() == 15 then
			local item = entry:get_completion_item()
			if not item.documentation and item.insertText then
				item.documentation = {
					kind = "markdown",
					value = string.format("```%s\n%s\n```", vim.bo.filetype, M.cmp.snippet_preview(item.insertText)),
				}
			end
		end
	end
end

return M
