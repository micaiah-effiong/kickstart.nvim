return {
	-- Theme inspired by Atom
	'navarasu/onedark.nvim',
	config = function()
		require('onedark').setup {
			priority = 1000,
			toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
			style = 'dark',
			toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
		}
		vim.cmd.colorscheme 'onedark'
	end,
}
