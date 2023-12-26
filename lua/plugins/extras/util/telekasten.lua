return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "renerocksai/calendar-vim", "lukas-reineke/headlines.nvim" },
    config = function()
      require("plugins.config.telekasten")
    end,

    cmd = "Telekasten",
    keys = {
      {
        "<leader>n",

        desc = "+Notes",
      },
      {
        "<leader>nc",
        "<cmd>Telekasten show_calendar<cr>",
        desc = "Calendar",
      },
      {
        "<leader>nd",
        "<cmd>vsplit || Telekasten goto_today<cr>",
        desc = "Daily",
      },
      {
        "<leader>nD",
        "<cmd>Telekasten find_daily_notes<cr>",
        desc = "Find dailies",
      },
      {
        "<leader>nf",
        "<cmd>Telekasten find_notes<cr>",
        desc = "Find Notes",
      },
      {
        "<leader>nF",
        "<cmd>Telekasten follow_link<cr>",
        desc = "Follow Link",
      },
    },
  },
}
