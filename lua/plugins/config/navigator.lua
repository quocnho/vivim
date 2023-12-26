-- local capabilities = vim.lsp.protocol.make_client_capabilities()

local single = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

-- loader('aerial.nvim')
local nav_cfg = {
	width = 0.7,
	-- icons = {icons = false}, -- disable all icons
	on_attach = function(client, bufnr)
		-- require'aerial'.on_attach(client, bufnr)
	end,
	border = single, -- "single",
	ts_fold = false, -- "ufo"
	-- external = true, -- true: enable for goneovim multigrid otherwise false
	lsp_signature_help = true,
	combined_attach = "their", -- both: use both customized attach and navigator default attach, mine: only use my attach defined in vimrc

	treesitter_navigation = { "go", "typescript", "lua" },
	-- default_mapping = false,
	--     keymaps = { { mode = 'i', key = '<M-k>', func = 'signature_help()' },
	-- { key = "<c-i>", func = "signature_help()" } },
	lsp = {
		format_on_save = { disable = { "vue" } }, -- set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
		disable_format_cap = {
			"sqls",
			"gopls",
			"jsonls",
			"sumneko_lua",
			"lua_ls",
			"tflint",
			"terraform_lsp",
			"terraformls",
		}, -- a list of lsp not enable auto-format (e.g. if you using efm or vim-codeformat etc)
		disable_lsp = { "clangd", "rust_analyzer" }, --e.g {denols}
		-- code_lens = true,
		disply_diagnostic_qf = false, -- update diagnostic in quickfix window
		denols = { filetypes = {} },
		rename = { style = "floating-preview" },
		lua_ls = {
			before_init = require("neodev.lsp").before_init,
		},
		tsserver = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			on_attach = function(client, bufnr, opts)
				client.server_capabilities.documentFormattingProvider = false -- allow efm to format
				-- require("aerial").on_attach(client, bufnr, opts)
			end,
		},
		flow = { autostart = false },

		sqls = {
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false -- efm
			end,
		},
		ccls = { filetypes = {} }, -- using clangd
		-- clangd = { filetypes = {} }, -- using clangd

		jedi_language_server = { filetypes = {} }, --another way to disable lsp
		servers = { "terraform_lsp", "vuels", "tailwindcss" },
	},
}
nav_cfg.lsp.gopls = function()
	local go = pcall(require, "go")
	if go then
		local cfg = require("go.lsp").config()
		local att = cfg.on_attach
		cfg.on_attach = function(client, bufnr)
			print("gopls on_attach")
			client.server_capabilities.documentFormattingProvider = false -- efm/null-ls
			att(client, bufnr)
		end
		return cfg
	else
		return {}
	end
end

table.insert(nav_cfg.lsp.disable_lsp, "efm")

vim.lsp.set_log_level("error") -- error debug info
-- require"navigator".setup(nav_cfg)
require("navigator").setup(nav_cfg)
