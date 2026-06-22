vim.pack.add({
	Gh('tpope/vim-fugitive'),
})

-- TODO: setup only if fugitive is ready
vim.keymap.set('n', '<leader>gs', ':G<CR>')
vim.keymap.set('n', '<leader>gb', ':G blame<CR>')
