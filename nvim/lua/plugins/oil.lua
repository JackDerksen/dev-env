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
      ["<CR>"] = "actions.select",
      ["-"] = "actions.parent",
      ["g."] = "actions.toggle_hidden",
    },
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
            return icon, "Normal"
          end,
        },
      },
    },
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
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      win_options = {
        winblend = 0,
        winhl = "Normal:Normal,Float:Float",
      },
    },
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
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
