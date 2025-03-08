return {
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- more opts go here
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
