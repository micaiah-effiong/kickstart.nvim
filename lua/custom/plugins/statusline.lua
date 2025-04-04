local function base_cwd()
	return require("custom.utils.find_git_root").basename
end

return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = 'auto',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_c = {
				{ base_cwd, separator = "" },
				'filename',
			},
		}
	},
}
