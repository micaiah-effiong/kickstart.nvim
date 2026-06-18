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
	}
}

for server_name, config in pairs(servers) do
	-- print('server_name => ' .. server_name)
	config.capabilities = vim.lsp.protocol.make_client_capabilities()
	config.on_attach = require('custom.utils.lsp_on_attach')
	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end
