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
local function mod_name(repo)
  return 'https://github.com/' .. repo
end

-- NOTE: Load and setup these plugins first
vim.pack.add({
  mod_name('folke/which-key.nvim'),
  mod_name('navarasu/onedark.nvim'),
  mod_name('j-hui/fidget.nvim'),
  mod_name('folke/lazydev.nvim'),
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

  -- register which-key VISUAL mode
  -- required for visual <leader>hs (hunk stage) to work
  -- { '<leader>',  group = 'VISUAL <leader>', mode = { 'v' } },
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
  mod_name('tpope/vim-fugitive'),
  mod_name('tpope/vim-sleuth'),
  mod_name('lukas-reineke/indent-blankline.nvim'),

  -- barbecue
  mod_name('SmiteshP/nvim-navic'),
  mod_name('nvim-tree/nvim-web-devicons'),
  mod_name('utilyre/barbecue.nvim'),
  --

  -- bufferline
  mod_name('nvim-tree/nvim-web-devicons'),
  mod_name('akinsho/bufferline.nvim'),
  --

  mod_name('lewis6991/gitsigns.nvim'),

  -- render-markdown
  mod_name('nvim-treesitter/nvim-treesitter'),
  mod_name('nvim-tree/nvim-web-devicons'),
  mod_name('MeanderingProgrammer/render-markdown.nvim'),
  --

  -- render-preview
  mod_name('selimacerbas/live-server.nvim'),
  mod_name('selimacerbas/markdown-preview.nvim'),
  --

  mod_name('micaiah-effiong/task.nvim'),
  mod_name('nvim-lualine/lualine.nvim'),

  -- todo-comments
  mod_name('nvim-lua/plenary.nvim'),
  mod_name('folke/todo-comments.nvim'),
  --

  mod_name('folke/trouble.nvim'),

  -- telescope
  mod_name('nvim-lua/plenary.nvim'),
  mod_name('nvim-telescope/telescope-fzf-native.nvim'),
  { src = mod_name('nvim-telescope/telescope.nvim'), version = "v0.2.2" },
  --

  -- meson-lspconfig
  mod_name('mason-org/mason.nvim'),
  mod_name('neovim/nvim-lspconfig'),
  mod_name('mason-org/mason-lspconfig.nvim'),
  --

  -- nvim-cmp
  -- Snippet Engine & its associated nvim-cmp source
  mod_name('L3MON4D3/LuaSnip'),
  mod_name('saadparwaiz1/cmp_luasnip'),
  -- Adds LSP completion capabilities
  mod_name('hrsh7th/cmp-nvim-lsp'),
  mod_name('hrsh7th/cmp-path'),
  -- Adds a number of user-friendly snippets
  mod_name('rafamadriz/friendly-snippets'),
  mod_name('hrsh7th/nvim-cmp'),
  --

  -- DB
  mod_name('ellisonleao/dotenv.nvim'),
  mod_name('tpope/vim-dadbod'),
  mod_name('kristijanhusak/vim-dadbod-completion'),
  mod_name('kristijanhusak/vim-dadbod-ui'),
  --

  mod_name('brenoprata10/nvim-highlight-colors'),
})

require('custom.plugins')
require('custom.settings')
