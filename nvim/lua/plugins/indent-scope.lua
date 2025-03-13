return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "Trouble",
          "help",
          "lazy",
          "mason",
          "trouble",
          "snacks",
        },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      -- Add toggle functionality
      local function toggle_indent_guides()
        local ibl = require("ibl")
        local config = require("ibl.config").get_config(0)
        if config.enabled then
          ibl.setup_buffer(0, { enabled = false })
          vim.notify("Indentation guides disabled", vim.log.levels.INFO)
        else
          ibl.setup_buffer(0, { enabled = true })
          vim.notify("Indentation guides enabled", vim.log.levels.INFO)
        end
      end

      -- Add keymapping for toggling
      vim.keymap.set("n", "<leader>ig", toggle_indent_guides, { desc = "Toggle indentation guides" })
    end,
    main = "ibl",
  },
}
