require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		"bashls",
		"eslint",
		"html",
		"lua_ls",
		"rust_analyzer",
		"tailwindcss",
		"ts_ls",
		"emmet_language_server"
	},
})
