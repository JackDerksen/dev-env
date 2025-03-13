-- Helper function for setting keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Define keymapping categories
local M = {}

-- General mappings
M.setup_general = function()
  -- Move selected lines with shift+j or shift+k
  map("v", "J", ":m '>+1<CR>gv=gv")
  map("v", "K", ":m '<-2<CR>gv=gv")

  -- Copy contents of a function
  map("n", "YY", "va{Vy")

  -- Join line while keeping the cursor in the same position
  map("n", "J", "mzJ`z")

  -- Keep cursor centred while scrolling up and down
  map("n", "<C-d>", "<C-d>zz")
  map("n", "<C-u>", "<C-u>zz")

  -- Next and previous instance of the highlighted letter
  map("n", "n", "nzzzv")
  map("n", "N", "Nzzzv")

  -- Better paste (prevents new paste buffer)
  map("x", "<leader>p", [["_dP]], { desc = "Better paste" })

  -- Copy to system clipboard
  map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
  map("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })

  -- Delete to void register
  map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

  -- Fixed ctrl+c weirdness to exit from vertical select mode
  map({ "i", "v" }, "<C-c>", "<Esc>")

  -- Delete shift+q keymap
  map("n", "Q", "<nop>")

  -- Search and replace current position word
  map(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search and replace highlighted word" }
  )

  -- Make file executable
  map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })
end

-- Window management mappings
M.setup_windows = function()
  map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
  map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
  map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })

  -- Resize window using <ctrl> arrow keys
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

-- Commenting mappings
M.setup_commenting = function()
  map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
  map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })
end

-- File explorer (Oil) mappings
M.setup_explorer = function()
  map("n", "<leader>e", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Toggle Oil" })
end

-- Buffer navigation mappings
M.setup_buffers = function()
  map("n", "<C-Right>", ":bnext<CR>", { silent = true })
  map("n", "<C-Left>", ":bprevious<CR>", { silent = true })
end

-- Plugin management mappings
M.setup_plugin_manager = function()
  map("n", "<leader>l", "<cmd>Lazy<CR>", { silent = true })
end

-- Cellular-Automaton mappings
M.setup_automaton = function()
  map("n", "<leader>ar", "<cmd>CellularAutomaton make_it_rain<CR>", { silent = true, desc = "Make it rain" })
  map("n", "<leader>ag", "<cmd>CellularAutomaton game_of_life<CR>", { silent = true, desc = "Game of life" })
  map("n", "<leader>as", "<cmd>CellularAutomaton scramble<CR>", { silent = true, desc = "Scramble" })
end

-- Git mappings
M.setup_git = function()
  local gs = package.loaded.gitsigns
  if not gs then
    return
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

  -- Add first/last hunk navigation
  map("n", "]C", function()
    gs.nav_hunk("last")
  end, { desc = "Last hunk" })
  map("n", "[C", function()
    gs.nav_hunk("first")
  end, { desc = "First hunk" })

  -- Git operations
  map("n", "<leader>gs", gs.stage_buffer, { desc = "Git stage buffer" })
  map("n", "<leader>gR", gs.reset_buffer, { desc = "Git reset buffer" })
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end, { desc = "Git blame line" })
  map("n", "<leader>gB", gs.blame, { desc = "Git blame buffer" })
  map("n", "<leader>gd", gs.diffthis, { desc = "Git diff this" })
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end, { desc = "Git diff with parent" })

  -- Hunk operations
  map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
  map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
  map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
  map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
  map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
  map("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Preview hunk inline" })

  -- Toggle features
  map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
  map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
  map("n", "<leader>gts", gs.toggle_signs, { desc = "Toggle signs" })
  map("n", "<leader>gtn", gs.toggle_numhl, { desc = "Toggle number highlight" })
  map("n", "<leader>gtl", gs.toggle_linehl, { desc = "Toggle line highlight" })
  map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Toggle word diff" })

  -- Text object
  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
end

-- Tmux navigation mappings
M.setup_tmux = function()
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate Left" })
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate Right" })
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate Down" })
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate Up" })
end

-- Telescope mappings
M.setup_telescope = function()
  local has_telescope, builtin = pcall(require, "telescope.builtin")
  if has_telescope then
    map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
    map("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
  end
end

-- Harpoon mappings
M.setup_harpoon = function()
  -- Set up harpoon key bindings
  local has_harpoon, harpoon = pcall(require, "harpoon")
  if has_harpoon then
    map("n", "<leader>H", function()
      harpoon:list():add()
    end, { desc = "Harpoon File" })

    map("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon Quick Menu" })

    -- Number keys for harpoon navigation
    for i = 1, 5 do
      map("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon to File " .. i })
    end
  end
end

-- LSP mappings
M.setup_lsp = function()
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
end

-- Trouble.nvim mappings
M.setup_trouble = function()
  map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
  map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
  map("n", "<leader>cs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
  map("n", "<leader>cS", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions/... (Trouble)" })
  map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
  map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

  -- Previous/Next item navigation
  map("n", "[q", function()
    if require("trouble").is_open() then
      require("trouble").prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, { desc = "Previous Trouble/Quickfix Item" })

  map("n", "]q", function()
    if require("trouble").is_open() then
      require("trouble").next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, { desc = "Next Trouble/Quickfix Item" })
end

-- Undotree mappings
M.setup_undotree = function()
  map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
end

-- Format mappings
M.setup_format = function()
  local has_conform, conform = pcall(require, "conform")
  if has_conform then
    map("n", "<leader>cf", function()
      conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })
  end
end

-- Setup all mappings
local function setup()
  M.setup_general()
  M.setup_windows()
  M.setup_commenting()
  M.setup_explorer()
  M.setup_buffers()
  M.setup_plugin_manager()

  -- Plugin-specific mappings
  -- These will only be set up if the plugin is loaded
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      M.setup_automaton()
      M.setup_git()
      M.setup_tmux()
      M.setup_telescope()
      M.setup_harpoon()
      M.setup_lsp()
      M.setup_trouble()
      M.setup_undotree()
      M.setup_format()
    end,
  })
end

-- Initialize all keymaps
setup()

return M
