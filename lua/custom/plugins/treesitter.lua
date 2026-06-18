require('nvim-treesitter').setup({
	install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
	'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'markdown',
	'markdown_inline'
})
