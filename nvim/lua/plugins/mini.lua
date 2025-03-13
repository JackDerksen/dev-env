return {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  config = function()
    require("mini.pairs").setup({
      -- In which modes mappings from this `config` should be created
      modes = {
        insert = true,
        command = true,
        terminal = false,
      },
      -- Characters to be matched:
      -- For example, `<` and `>` for angle brackets. Currently disabled because of equality operators
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
      -- Don't pair in treesitter string nodes
      disable_filetype = {},
      -- Don't pair when next character is alphanumeric
      disable_same_count = false,
    })
  end,
}
