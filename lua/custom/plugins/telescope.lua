vim.pack.add({
	Gh('nvim-lua/plenary.nvim'),
	Gh('nvim-telescope/telescope-fzf-native.nvim'),
	{ src = Gh('nvim-telescope/telescope.nvim'), version = "v0.2.2" },
})

local telescope_builtin = require('telescope.builtin')
-- Custom git_files function to search cwd
local function telescope_find_git_files_in_cwd()
	telescope_builtin.git_files {
		use_git_root = false,
		prompt_title = 'Find git files in current workspace',
	}
end

-- Custom find_files function to search cwd
local function telescope_find_files_in_cwd()
	telescope_builtin.find_files {
		cwd = vim.fn.getcwd(),
		prompt_title = 'Find files in current workspace',
	}
end

-- Custom live_grep function to search in git root
local function telescope_live_grep_open_files()
	telescope_builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end

local function live_grep_git_root()
	local find_git_root = require("custom.utils.find_git_root").find_git_root
	local git_root = find_git_root(true)
	if git_root then
		telescope_builtin.live_grep {
			search_dirs = { git_root },
		}
	end
end

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}


-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })


vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', telescope_builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>scg', telescope_find_git_files_in_cwd, { desc = '[S]earch [C]urrrent [G]it Files' })
vim.keymap.set('n', '<leader>scf', telescope_find_files_in_cwd, { desc = '[S]earch [C]urrent [F]iles' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', live_grep_git_root, { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
