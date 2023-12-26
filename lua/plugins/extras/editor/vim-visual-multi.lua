return {
  {
    "mg979/vim-visual-multi",
    lazy = true,
    keys = {
      "<C-n>",
      "<C-N>",
      "<M-n>",
      "<S-Down>",
      "<S-Up>",
      "<M-Left>",
      "<M-i>",
      "<M-Right>",
      "<M-D>",
      "<M-Down>",
      "<C-d>",
      "<C-Down>",
      "<C-Up>",
      "<S-Right>",
      "<C-LeftMouse>",
      "<M-LeftMouse>",
      "<M-C-RightMouse>",
    },
    event = "BufReadPost",
    config = function()
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_silent_exit = 0
      vim.g.VM_show_warnings = 1
      vim.g.VM_default_mappings = 1
    end,
  },
}
