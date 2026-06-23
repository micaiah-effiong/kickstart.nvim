vim.pack.add({
	Gh('neovim/nvim-lspconfig'),
	Gh('mason-org/mason-lspconfig.nvim'),
	Gh('mason-org/mason.nvim'),
})

---@type table<string, vim.lsp.Config>
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = {
						'vim',
						'require'
					},
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						'${3rd}/luv/library',
						vim.api.nvim_get_runtime_file("", true),
					},

				},
				telemetry = {
					enable = false,
				},
			},
		},
	},

	rust_analyzer = {
		["rust-analyzer"] = {
			checkOnSave = true,
		},
	},

	emmet_language_server = {
		filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "xml" },
	},

	bashls = {},
	eslint = {},
	html = {},
	tailwindcss = {},
	ts_ls = {},
}

require('mason').setup()
local masonlsp_config = require('mason-lspconfig')
masonlsp_config.setup({ ensure_installed = vim.tbl_keys(servers) })

for _, server_name in ipairs(masonlsp_config.get_installed_servers()) do
	local config = servers[server_name] or {}

	config.capabilities = vim.lsp.protocol.make_client_capabilities()
	config.on_attach = require('custom.utils.lsp_on_attach')

	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end
