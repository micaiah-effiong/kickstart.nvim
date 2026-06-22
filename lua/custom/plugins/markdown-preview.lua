vim.pack.add({
	Gh('selimacerbas/live-server.nvim'),
	Gh('selimacerbas/markdown-preview.nvim'),
})

require("markdown_preview").setup({
	instance_mode = "takeover",
	port = 0,
	open_browser = true,
	default_theme = "dark",
	debounce_ms = 300,
})
