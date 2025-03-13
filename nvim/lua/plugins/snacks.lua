return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
██╗███████╗███╗   ███╗  ████╗   ██████╗  ███████╗
██║██╔════╝████╗ ████║ ██╔═██╗ ██╔═══██╗██╔═════╝
██║█████╗  ██╔████╔██║██╔╝  ██╗██║   ╚═╝╚██████╗ 
╚═╝██╔══╝  ██║ ██╔╝██║████████║██║   ██╗ ╚════██╗
██╗███████╗██║ ╚═╝ ██║██╔═══██║╚██████╔╝███████╔╝
╚═╝╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝ ╚═════╝ ╚══════╝ 
fast as fuck, boi
]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },

      -- Use the compact files layout structure
      sections = {
        { section = "header" },
        { icon = "", title = "Keymaps", section = "keys", indent = 0, padding = 1 },
        { icon = "", title = "Recent Files", section = "recent_files", indent = 0, padding = 1 },
        { icon = "", title = "Projects", section = "projects", indent = 0, padding = 1 },
        { section = "startup" },
      },

      wo = {
        winhighlight = "Normal:Normal,NormalFloat:Normal",
      },
    },
  },
}
