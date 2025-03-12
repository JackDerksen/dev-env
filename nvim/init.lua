-- Load lazy.nvim plugin manager
require("config.lazy")

-- Load configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Set nicer line number highlighting
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#4C4f5A", bold = false })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#E2E2E3", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#4C4f5A", bold = false })
