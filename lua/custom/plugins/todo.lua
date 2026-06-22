vim.pack.add({
	Gh('nvim-lua/plenary.nvim'),
	Gh('folke/todo-comments.nvim'),
})

require("todo-comments").setup()
