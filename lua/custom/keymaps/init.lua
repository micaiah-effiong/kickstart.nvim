-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- copy file path
--
-- " full path
-- :let @+ = expand("%:p")
vim.keymap.set('n', '<leader>cbp', ':let @+ = expand("%:p")<CR>', {
  desc = "[C]opy [B]uffer [P]ath"
})

-- " relative path
-- :let @+ = expand("%")
vim.keymap.set('n', '<leader>cbr', ':let @+ = expand("%")<CR>', {
  desc = "[C]opy [B]uffer [R]elative path"
})

-- " just filename
-- :let @+ = expand("%:t")
vim.keymap.set('n', '<leader>cbn', ':let @+ = expand("%:t")<CR>', {
  desc = "[C]opy [B]uffer [N]ame"
})

vim.keymap.set('n', '<C-b>', ':Lexplore<CR>', { desc = 'Toggle netrw' })
