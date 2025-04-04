-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root(should_log)
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
      [1]
  if vim.v.shell_error ~= 0 then
    if should_log then
      print 'Not a git repository. Searching on current working directory'
      return cwd
    end
    return nil
  end
  return git_root
end

local function dirname()
  local cwd = find_git_root()

  if cwd == nil then
    return ""
  end
  return " " .. vim.fs.basename(cwd)
end

local basename = dirname()

return {
  find_git_root = find_git_root,
  basename = basename
}
