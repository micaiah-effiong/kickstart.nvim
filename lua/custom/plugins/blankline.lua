vim.pack.add({
  Gh('lukas-reineke/indent-blankline.nvim'),
})

require('ibl').setup({
  indent = {
    char = "┊",
    -- highlight = {
    --   "CursorColumn",
    --   "Whitespace",
    -- },
  },
  scope = {
    show_start = false,
  }
})
