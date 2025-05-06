return {
  -- dir = '~/Documents/code/npm-scripts.nvim',
  -- config = true,
  -- dev = true,
  "micaiah-effiong/npm-scripts.nvim",
  cond = function()
    return vim.fn.filereadable(vim.fn.getcwd() .. '/package.json') == 1
  end,
  config = function()
    require('npm')
    -- Optional: Add your key mapping here
    -- vim.api.nvim_set_keymap('n',
    --                         '<leader>npm',
    --                         ':Npm ',
    --                         { noremap = true, silent = false }
    --                        )
  end
}
