return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.config.colorizer")
    end,
    ft = { "html", "css", "sass", "javascript", "typescriptreact", "javascriptreact" },
    cmd = "ColorizerToggle",
  },
}
