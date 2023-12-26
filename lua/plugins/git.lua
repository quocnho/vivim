return {
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit", "NeogitResetState" },
		opts = {},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},

	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	lazy = true,
	-- 	cmd = { "Gitsigns" },
	-- 	opts = {
	-- 		current_line_blame = true,
	-- 	},
	-- },

	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewLog",
			"DiffviewRefresh",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
		},
		opts = function()
			local keymap_q_close = { "n", "q", ":DiffviewClose<cr>", { desc = "Diffview Close" } }

			return {
				enhanced_diff_hl = true,
				keymaps = {
					view = {
						keymap_q_close,
					},
					file_panel = {
						keymap_q_close,
					},
					file_history_panel = {
						keymap_q_close,
					},
				},
			}
		end,
	},
}
