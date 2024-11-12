return {
  {
    "rebelot/kanagawa.nvim",
    colors = {
      palette = {},
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        -- Save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "storm",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },

      on_colors = function(colors)
        --colors.bg = "#202324"
        colors.green = "#c3e88d"
        colors.border_highlight = "#c0caf5"

        -- Diagnostics colours
        colors.error = "#ff757f"
        colors.hint = "#4fd6be"
        colors.info = "#7dcfff"
        colors.warning = "#ffc777"
      end,

      on_highlights = function(highlights)
        highlights.DiagnosticVirtualTextError = {
          bg = highlights.none,
          fg = "#ff757f",
        }
        highlights.DiagnosticVirtualTextHint = {
          bg = highlights.none,
          fg = "#4fd6be",
        }
        highlights.DiagnosticVirtualTextInfo = {
          bg = highlights.none,
          fg = "#7dcfff",
        }
        highlights.DiagnosticVirtualTextWarn = {
          bg = highlights.none,
          fg = "#ffc777",
        }
        highlights.FloatBorder = {
          bg = highlights.none,
          fg = "#c0caf5",
        }
        highlights.FloatTitle = {
          bg = highlights.none,
          fg = "#ff757f",
        }
        highlights.TelescopeBorder = {
          bg = highlights.none,
          fg = "#c0caf5",
        }
        highlights.TelescopeNormal = {
          bg = highlights.none,
        }
        highlights.cmpDocumentation = {
          bg = "#24283b",
          fg = "#c0caf5",
        }
        highlights.cmpDocumentationBorder = {
          bg = "#24283b",
          fg = "#c0caf5",
        }
      end,
    },
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Configuration goes here
      vim.g.sonokai_style = "default"
      vim.g.sonokai_enable_italic = false
      vim.g.sonokai_disable_italic_comment = true
    end,
  },
  { -- Current colorscheme
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
