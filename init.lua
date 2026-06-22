require("vim._core.ui2").enable({})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- -- [[ Highlight on yank ]]
-- -- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if vim.fn.executable 'make' ~= 1 then
      return
    end

    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end
})

---@param repo string
function Gh(repo)
  return 'https://github.com/' .. repo
end

-- NOTE: Load and setup these plugins first
vim.pack.add({
  Gh('folke/which-key.nvim'),
  Gh('navarasu/onedark.nvim'),
  Gh('j-hui/fidget.nvim'),
  Gh('folke/lazydev.nvim'),
})
require('custom.plugins.onedark-theme')
-- document existing key chains
require('which-key').add({
  { '<leader>c', name = '[C]ode' },
  { '<leader>d', name = '[D]ocument', },
  { '<leader>g', name = '[G]it', },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>r', name = '[R]ename', },
  { '<leader>s', name = '[S]earch', },
  { '<leader>t', name = '[T]oggle', },
  { '<leader>w', name = '[W]orkspace', },
})
require('fidget').setup({})
require('lazydev').setup({
  library = {
    { path = vim.env.VIMRUNTIME },
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

-- NOTE: Lazy load the rest
vim.pack.add({
  Gh('tpope/vim-sleuth'),
  Gh('stevearc/dressing.nvim'),
})

require('custom.plugins')
require('custom.settings')
