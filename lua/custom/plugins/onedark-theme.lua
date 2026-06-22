local theme = require('onedark')
theme.setup({
	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
	style = 'warmer',
	-- toggle_style_key = nil,
	highlights = {
		-- WinBar = { bg = "$bg0", fg = "$fg" },         -- active window
		-- WinBarNC = { bg = "$bg0", fg = "$light_grey" }, -- inactive window
	}
})

vim.cmd.colorscheme 'onedark'
require('which-key').add({
	{
		'<leader>ts',
		theme.toggle,
		desc = "[T]oggle onedark theme style",
		mode = "n"
	}
})
