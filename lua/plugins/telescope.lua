return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      'nvim-telescope/telescope-symbols.nvim',
      -- { "nvim-telescope/telescope-media-files.nvim", lazy = true },
      'nvim-telescope/telescope-hop.nvim',
    },
    lazy = true,
    config = function()
      require("plugins.config.telescope")
    end,
  },
}

