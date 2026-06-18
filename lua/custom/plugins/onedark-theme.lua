local theme = require('onedark')
theme.setup({
	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
	style = 'warmer',
	highlights = {
		-- Match active window winbar with the active buffer background
		WinBar = { bg = "$bg0", fg = "$fg" },
		-- Match inactive window winbar with the inactive buffer background
		WinBarNC = { bg = "$bg0", fg = "$light_grey" },
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
