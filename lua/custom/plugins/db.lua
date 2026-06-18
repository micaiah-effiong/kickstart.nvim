require('dotenv').setup({ enable_on_load = true })

require('cmp').setup.filetype(
	{ 'sql', 'mysql', 'plsql' },
	{
		sources = {
			{ name = 'vim-dadbod-completion' },
			{ name = 'buffer' },
		}
	}
)

-- Your DBUI configuration
vim.g.db_ui_use_nerd_fonts = 1
