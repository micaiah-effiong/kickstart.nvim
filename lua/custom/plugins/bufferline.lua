vim.pack.add({
	-- bufferline
	Gh('nvim-tree/nvim-web-devicons'),
	Gh('akinsho/bufferline.nvim'),
	--
})

require('bufferline').setup {
	options = {
		diagnostics = "nvim_lsp",
		--[[ offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		} ]]
	},
}
