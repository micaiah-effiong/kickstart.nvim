return {
	'williamboman/mason-lspconfig',
	opts = {
		automatic_enable = false,
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
