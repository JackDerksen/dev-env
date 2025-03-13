return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local function setup_colors()
      return {
        bright_bg = "#2c2e34",
        bright_fg = "#e2e2e3",
        red = "#fc5d7c",
        green = "#9ed072",
        blue = "#76cce0",
        light_gray = "#8d95b1",
        dark_gray = "#33353f",
        orange = "#f39660",
        purple = "#b39df3",
        cyan = "#76cce0",

        diag_warn = "#f39660",
        diag_error = "#fc5d7c",
        diag_hint = "#76cce0",
        diag_info = "#9ed072",
        git_del = "#fc5d7c",
        git_add = "#9ed072",
        git_change = "#76cce0",
        branch_bg = "#8d95b1",
        diff_bg = "#6f758b",
        diag_bg = "#515565",
        middle_bg = "#33353f",

        normal = "#b39df3", -- purple
        insert = "#76cce0", -- blue
        visual = "#f39660", -- orange
        replace = "#fc5d7c", -- red
        command = "#9ed072", -- green
        inactive = "#33353f",
      }
    end

    -- Initialize colors right away and then again on colorscheme change
    local colors = setup_colors()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        colors = setup_colors()
        require("heirline").reset_highlights()
        require("heirline").clear_colors()
        require("heirline").load_colors(colors)
      end,
    })

    -- Separators
    local separators = {
      left = "",
      right = "",
      left_filled = "",
      right_filled = "",
      space = " ",
    }

    -- Mode component with separators and dynamic colors
    local Mode = {
      init = function(self)
        self.mode = vim.fn.mode(1)

        -- Set the color based on the mode
        if self.mode:match("^n") then
          self.mode_color = colors.normal
        elseif self.mode:match("^i") then
          self.mode_color = colors.insert
        elseif self.mode:match("^v") or self.mode:match("^V") or self.mode:match("^\22") then
          self.mode_color = colors.visual
        elseif self.mode:match("^R") then
          self.mode_color = colors.replace
        elseif self.mode:match("^c") then
          self.mode_color = colors.command
        else
          self.mode_color = colors.normal
        end
      end,
      static = {
        mode_names = {
          n = "NORMAL",
          no = "OP",
          nov = "OP",
          noV = "OP",
          ["no\22"] = "OP",
          niI = "NORMAL",
          niR = "NORMAL",
          niV = "NORMAL",
          v = "VISUAL",
          V = "V-LINE",
          ["\22"] = "V-BLOCK",
          s = "SELECT",
          S = "S-LINE",
          ["\19"] = "S-BLOCK",
          i = "INSERT",
          ic = "INSERT",
          ix = "INSERT",
          R = "REPLACE",
          Rc = "REPLACE",
          Rv = "V-REPLACE",
          Rx = "REPLACE",
          c = "COMMAND",
          cv = "COMMAND",
          ce = "COMMAND",
          r = "PROMPT",
          rm = "MORE",
          ["r?"] = "CONFIRM",
          ["!"] = "SHELL",
          t = "TERMINAL",
        },
      },
      {
        provider = function(self)
          return "  " .. self.mode_names[self.mode] .. " "
        end,
        hl = function(self)
          return {
            fg = colors.bright_bg,
            bg = self.mode_color,
            bold = true,
          }
        end,
      },
      {
        provider = separators.right_filled,
        hl = function(self)
          return {
            fg = self.mode_color,
            bg = "NONE", -- Default to transparent
          }
        end,
      },
      update = {
        "ModeChanged",
        "CursorHold",
        "CursorHoldI",
        "CursorMoved",
        "CursorMovedI",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
    }

    -- Git branch with separators
    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,
      {
        provider = function(self)
          return "  " .. self.status_dict.head .. " "
        end,
        hl = {
          fg = colors.dark_gray,
          bg = colors.branch_bg,
          bold = true,
        },
      },
      {
        provider = separators.right_filled,
        hl = function()
          return {
            fg = colors.branch_bg,
            bg = colors.diff_bg,
          }
        end,
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        {
          provider = "",
          hl = { bg = colors.diff_bg },
        },
        {
          provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" +" .. count)
          end,
          hl = { fg = colors.dark_gray, bg = colors.diff_bg },
        },
        {
          provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count)
          end,
          hl = { fg = colors.dark_gray, bg = colors.diff_bg },
        },
        {
          provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" -" .. count)
          end,
          hl = { fg = colors.dark_gray, bg = colors.diff_bg },
        },
        {
          provider = " ",
          hl = { bg = colors.diff_bg },
        },
      },
      {
        provider = separators.right_filled,
        hl = function()
          return {
            fg = colors.diff_bg,
            bg = conditions.has_diagnostics() and colors.diag_bg or "NONE",
          }
        end,
      },
      update = {
        "ModeChanged",
        "CursorMoved",
        "CursorMovedI",
        "BufEnter",
        "BufLeave",
        "DiagnosticChanged",
        "User",
        "VimResized",
        "WinEnter",
        "WinLeave",
      },
    }

    -- Diagnostics with separators
    local Diagnostics = {
      condition = conditions.has_diagnostics,
      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      update = { "DiagnosticChanged", "BufEnter", "User" },
      {
        -- Only add this if Git isn't shown
        condition = function()
          return not conditions.is_git_repo()
        end,
        provider = separators.right,
        hl = function()
          return {
            fg = colors.diag_bg,
            bg = "NONE",
          }
        end,
      },
      {
        provider = "",
        hl = { bg = colors.diag_bg },
      },
      {
        provider = function(self)
          return self.errors > 0 and ("  " .. self.errors)
        end,
        hl = { fg = colors.light_gray, bg = colors.diag_bg },
      },
      {
        provider = function(self)
          return self.warnings > 0 and ("  " .. self.warnings)
        end,
        hl = { fg = colors.light_gray, bg = colors.diag_bg },
      },
      {
        provider = function(self)
          return self.info > 0 and ("  " .. self.info)
        end,
        hl = { fg = colors.light_gray, bg = colors.diag_bg },
      },
      {
        provider = function(self)
          return self.hints > 0 and (" 󰍉 " .. self.hints)
        end,
        hl = { fg = colors.light_gray, bg = colors.diag_bg },
      },
      {
        provider = " ",
        hl = { bg = colors.diag_bg },
      },
      {
        provider = separators.right_filled,
        hl = function()
          return {
            fg = colors.diag_bg,
            bg = colors.middle_bg, -- Middle section background
          }
        end,
      },
    }

    -- File info
    local FileInfo = {
      provider = function()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        return " " .. (icon or "") .. " " .. filename .. " "
      end,
      hl = { bg = colors.middle_bg },
    }

    -- File size
    local FileSize = {
      provider = function()
        local suffix = { "b", "k", "M", "G", "T", "P", "E" }
        local size = vim.fn.getfsize(vim.fn.expand("%:p"))
        if size <= 0 then
          return ""
        end
        local i = 1
        while size > 1024 do
          size = size / 1024
          i = i + 1
        end
        return string.format("%.2f%s ", size, suffix[i])
      end,
      hl = { bg = colors.middle_bg },
    }

    -- File type with separators
    local FileType = {
      {
        provider = separators.left_filled,
        hl = function()
          return {
            fg = colors.red,
            bg = colors.middle_bg, -- From middle section
          }
        end,
      },
      {
        provider = function()
          return " " .. vim.bo.filetype .. " "
        end,
        hl = {
          fg = colors.bright_bg,
          bg = colors.red,
        },
      },
    }

    -- Location with separators and fixed width
    local Location = {
      {
        provider = separators.left_filled,
        hl = function()
          return {
            fg = colors.orange,
            bg = colors.red,
          }
        end,
      },
      {
        -- Use fixed width for line:col to prevent jumping
        provider = function()
          -- Format with leading spaces to ensure consistent width
          -- Assuming max 9999 lines and 999 columns
          local line = string.format("%4d", vim.fn.line("."))
          local col = string.format("%3d", vim.fn.col("."))
          return "  " .. line .. ":" .. col .. " "
        end,
        hl = {
          fg = colors.bright_bg,
          bg = colors.orange,
        },
      },
    }

    -- Spacers
    local Space = {
      provider = " ",
      hl = { bg = colors.middle_bg },
    }

    local LeftAlignSpacing = {
      provider = "%=",
      hl = { bg = colors.middle_bg },
    }

    -- Buffer beginning section
    local BufferStartSection = {
      condition = function()
        return not conditions.is_git_repo() and not conditions.has_diagnostics()
      end,
      {
        provider = function(self)
          local mode = vim.fn.mode(1)
          local mode_color

          -- Set the color based on the mode
          if mode:match("^n") then
            mode_color = colors.normal
          elseif mode:match("^i") then
            mode_color = colors.insert
          elseif mode:match("^v") or mode:match("^V") or mode:match("^\22") then
            mode_color = colors.visual
          elseif mode:match("^R") then
            mode_color = colors.replace
          elseif mode:match("^c") then
            mode_color = colors.command
          else
            mode_color = colors.normal
          end

          -- Return the right separator with correct colors
          return separators.right_filled
        end,
        hl = function()
          local mode = vim.fn.mode(1)
          local mode_color

          -- Set color based on mode
          if mode:match("^n") then
            mode_color = colors.normal
          elseif mode:match("^i") then
            mode_color = colors.insert
          elseif mode:match("^v") or mode:match("^V") or mode:match("^\22") then
            mode_color = colors.visual
          elseif mode:match("^R") then
            mode_color = colors.replace
          elseif mode:match("^c") then
            mode_color = colors.command
          else
            mode_color = colors.normal
          end

          return {
            fg = mode_color,
            bg = colors.middle_bg,
          }
        end,
      },
    }

    -- Status line
    local StatusLine = {
      init = function(self)
        -- Get the current mode
        self.mode = vim.fn.mode(1)

        -- Set the colors for dynamic mode
        if self.mode:match("^n") then
          self.mode_color = colors.normal
        elseif self.mode:match("^i") then
          self.mode_color = colors.insert
        elseif self.mode:match("^v") or self.mode:match("^V") or self.mode:match("^\22") then
          self.mode_color = colors.visual
        elseif self.mode:match("^R") then
          self.mode_color = colors.replace
        elseif self.mode:match("^c") then
          self.mode_color = colors.command
        else
          self.mode_color = colors.normal
        end
      end,

      Mode,
      Git,
      Diagnostics,
      BufferStartSection,
      FileInfo,
      LeftAlignSpacing,
      FileSize,
      FileType,
      Location,

      -- Update on mode change
      update = { "ModeChanged", "CursorMoved", "User", "CursorMovedI", "BufEnter", "BufLeave" },
    }

    -- Inactive status line
    local InactiveStatusLine = {
      condition = function()
        return not conditions.is_active()
      end,

      -- Simplified components for inactive windows
      {
        provider = function()
          local filename = vim.fn.expand("%:t")
          local extension = vim.fn.expand("%:e")
          local icon, _ = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
          return " " .. (icon or "") .. " " .. filename .. " "
        end,
        hl = { fg = colors.bright_fg, bg = colors.inactive },
      },
      LeftAlignSpacing,
      {
        provider = function()
          return vim.bo.filetype
        end,
        hl = { fg = colors.bright_fg, bg = colors.inactive },
      },
      Space,
      {
        -- Fixed width here too
        provider = function()
          local line = string.format("%4d", vim.fn.line("."))
          local col = string.format("%3d", vim.fn.col("."))
          return line .. ":" .. col .. " "
        end,
        hl = { fg = colors.bright_fg, bg = colors.inactive },
      },
    }

    -- Initialize the statusline
    require("heirline").setup({
      statusline = {
        hl = { bg = "NONE" },
        {
          -- This will switch between active and inactive status line
          fallthrough = false,
          InactiveStatusLine,
          StatusLine,
        },
      },
    })

    -- Fix mode section not changing immediately in visual line mode
    vim.api.nvim_create_autocmd({ "ModeChanged", "VimEnter" }, {
      pattern = "*",
      callback = function()
        vim.cmd("redrawstatus")
      end,
    })

    vim.api.nvim_set_keymap("n", "v", "v<cmd>redrawstatus<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "V", "V<cmd>redrawstatus<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-v>", "<C-v><cmd>redrawstatus<CR>", { noremap = true, silent = true })

    -- Load the colors
    require("heirline").load_colors(colors)
  end,
}
