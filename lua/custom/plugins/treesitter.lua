vim.pack.add({
	Gh('nvim-treesitter/nvim-treesitter'),
	Gh('nvim-treesitter/nvim-treesitter-textobjects'),
})

require('nvim-treesitter').setup({
	install_dir = vim.fn.stdpath('data') .. '/site',
})

local languages = {
	'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript',
	'vimdoc', 'vim', 'bash', 'markdown', 'markdown_inline', 'html'
}

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function(args)
		local filetype = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(filetype) or filetype
		local has_parser = pcall(vim.treesitter.get_parser, args.buf, lang)

		if has_parser then
			vim.treesitter.start(args.buf, lang)
		end
	end,
})

require('nvim-treesitter-textobjects').setup({
	select = {
		enable = true,
		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		selection_modes = {
			-- You can use the capture groups defined in textobjects.scm
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			['@class.outer'] = '<c-v>', -- blockwise
		},
	},
})

local mode = { 'x', 'o' }

---@param rhs string
---@param query string
---@param desc string
local tselect = function(rhs, query, desc)
	vim.keymap.set(mode, rhs, function()
		require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
	end, { desc = desc })
end
tselect('af', '@function.outer', 'function')
tselect('if', '@function.inner', 'function')
tselect('aa', '@parameter.outer', 'parameter')
tselect('ia', '@parameter.inner', 'parameter')
tselect('ac', '@class.outer', 'class')
tselect('ic', '@class.inner', 'class')

vim.keymap.set("n", "<leader>a", function()
	require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>A", function()
	require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)

-- keymaps
local move_mode = { "n", "x", "o" }
local tmove = require("nvim-treesitter-textobjects.move")
vim.keymap.set(move_mode, "]m", function()
	tmove.goto_next_start("@function.outer", "textobjects")
end, { desc = "function" })
vim.keymap.set(move_mode, "]]", function()
	tmove.goto_next_start("@class.outer", "textobjects")
end, { desc = "class" })

vim.keymap.set(move_mode, "]M", function()
	tmove.goto_next_end("@function.outer", "textobjects")
end, { desc = "function" })
vim.keymap.set(move_mode, "][", function()
	tmove.goto_next_end("@class.outer", "textobjects")
end, { desc = "class" })

vim.keymap.set(move_mode, "[m", function()
	tmove.goto_previous_start("@function.outer", "textobjects")
end, { desc = "function" })
vim.keymap.set(move_mode, "[[", function()
	tmove.goto_previous_start("@class.outer", "textobjects")
end, { desc = "class" })

vim.keymap.set(move_mode, "[M", function()
	tmove.goto_previous_end("@function.outer", "textobjects")
end, { desc = "function" })
vim.keymap.set(move_mode, "[]", function()
	tmove.goto_previous_end("@class.outer", "textobjects")
end, { desc = "class" })
