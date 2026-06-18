local function base_cwd()
	return require("custom.utils.find_git_root").basename
end

require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'auto',
		component_separators = '|',
		section_separators = '',
		globalstatus = true
	},
	sections = {
		lualine_c = {
			{ base_cwd, separator = "" },
			'filename',
		},
	}
})
