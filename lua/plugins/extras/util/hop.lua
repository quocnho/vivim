return {
  {
    "smoka7/hop.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    keys = "etovxqpdygfblzhckisuranETOVXQPDYGFBLZHCKISURAN",
    config = function()
      require("plugins.config.hop")
    end,
  },
}
