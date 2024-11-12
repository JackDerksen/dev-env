return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      options = {
        theme = "sonokai",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            separator = { left = "", right = "" },
            color = {
              fg = "#2c2e34",
              bg = "#B39DF3",
            },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            separator = { left = "", right = "" },
            color = {
              fg = "#505464",
              bg = "#8d95b1",
            },
          },
          {
            "diff",
            separator = { left = "", right = "" },
            color = {
              bg = "#6f758b",
            },
            diff_color = {
              added = {
                fg = "#acb5d7",
              },
              modified = {
                fg = "#acb5d7",
              },
              removed = {
                fg = "#acb5d7",
              },
            },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            separator = { left = "", right = "" },
            color = {
              bg = "#515565",
            },
            diagnostics_color = {
              error = { fg = "#8e95b1" },
              warn = { fg = "#8e95b1" },
              info = { fg = "#8e95b1" },
            },
          },
          {
            "filename",
          },
        },
        lualine_x = { "filesize" },
        lualine_y = {
          {
            "filetype",
            icons_enabled = false,
            color = {
              fg = "#2c2e34",
              bg = "#fc5d7c",
            },
          },
        },
        lualine_z = {
          {
            "location",
            icon = "",
            color = {
              fg = "#2c2e34",
              bg = "#F39660",
            },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "neo-tree", "lazy", "oil" },
    }
  end,
}
