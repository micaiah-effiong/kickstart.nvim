return {
	'williamboman/mason-lspconfig',
	opts = {
		ensure_installed = {
			"bashls",
			"eslint",
			"html",
			"lua_ls",
			"rust_analyzer",
			"tailwindcss",
			"ts_ls",
		},
	}
}
