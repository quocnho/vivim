return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "nvimdev/dashboard-nvim",
    config = function()
      require("plugins.config.dashboard")
    end,
    optional = true,
    opts = function(_, opts)
      -- show dashboard when new tab page is opened
      vim.api.nvim_create_autocmd("TabNewEntered", { command = "Dashboard" })
    end,
    event = function()
      if vim.fn.argc() == 0 then
        return "VimEnter"
      end
    end,
    cmd = "Dashboard",
  },
}
