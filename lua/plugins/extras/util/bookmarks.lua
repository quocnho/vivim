return {
  {
    "tomasky/bookmarks.nvim",
    event = "VimEnter",
    lazy = true,
    config = function()
      require("plugins.config.bookmarks")
    end,
  },
}
