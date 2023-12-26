local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
  return
end

local icons = require("config.icons")

dashboard.setup({
  theme = "hyper", --  theme is doom and hyper default is hyper
  disable_move = false, --  defualt is false disable move keymap for hyper
  shortcut_type = "letter", --  shorcut type 'letter' or 'number'
  change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
  hide = {
    statusline = false, -- hide statusline default is true
    tabline = false, -- hide the tabline
    winbar = false, -- hide winbar
  },
  config = {
    week_header = {
      enable = true,
    },
    packages = { enable = false }, -- show how many plugins neovim loaded
    project = { enable = false, limit = 9 },
    mru = { limit = 8 },
    footer = { icons.ui.Rocket .. " Build, Ship, Innovate with Quốc Nho " .. icons.ui.Vim },
    shortcut = {
      {
        desc = " Restore",
        group = "Label",
        action = "lua require('persistence').load()",
        key = "s",
      },
      {
        desc = icons.ui.Search .. "Projects",
        group = "Label",
        action = "Telescope projects",
        key = "p",
      },
      {
        desc = icons.ui.Check .. "Todo",
        group = "Label",
        action = "Telekasten goto_today",
        key = "d",
      },
      {
        desc = icons.ui.Vim .. "Config",
        group = "@property",
        action = "e $MYVIMRC",
        key = "c",
      },
      {
        desc = icons.ui.Package .. "Lazy",
        group = "@property",
        action = "Lazy",
        key = "l",
      },
      {
        desc = "  Extras",
        group = "@property",
        action = "LazyExtras",
        key = "x",
      },
      {
        desc = icons.ui.Gear .. "Mason",
        group = "@property",
        action = "Mason",
        key = "m",
      },
      {
        desc = icons.ui.Power .. "Exit",
        group = "Action",
        action = "quit",
        key = "q",
      },
    },
  },
})
