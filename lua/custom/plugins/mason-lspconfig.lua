return {
	'williamboman/mason-lspconfig',
	version = "v1.32.0",
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
