local _augroups = {}

---@param client vim.lsp.Client
local function get_augroup(client)
  if not _augroups[client.id] then
    local group_name = 'lsp-auto-format-' .. client.name
    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
    _augroups[client.id] = id
  end

  return _augroups[client.id]
end

---@param buf integer
---@param client vim.lsp.Client
local function autoformat(client, buf)
  if client == nil then
    return
  end

  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  if client.name == 'ts_ls' then
    return
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = get_augroup(client),
    buffer = buf,
    callback = function()
      vim.lsp.buf.format({
        async = false,
        filter = function(c)
          return c.id == client.id
        end,
      })
    end,
  })
end


-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
---@param bufnr integer
---@param client vim.lsp.Client
local on_attach = function(client, bufnr)
  autoformat(client, bufnr)

  -- modes: string|string[], lhs: string, rhs: string|function, opts?: vim.keymap.set.Opts
  --- @param keys string
  --- @param func function
  --- @param desc string
  local function nmap(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action({ context = { only = { 'quickfix', 'refactor', 'source' }, diagnostics = {} } })
  end, '[C]ode [A]ction')

  -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- already used by vim.lsp
  nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', vim.lsp.buf.list_workspace_folders, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return on_attach
