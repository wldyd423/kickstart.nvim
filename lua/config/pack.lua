-- [[ Plugin manager helpers ]]
-- Plugins are managed by the built-in `vim.pack` (see `:help vim.pack`).
-- This module must be required before any module that calls `vim.pack.add`,
-- so the PackChanged autocmd below catches build steps on first install.
--
-- Useful commands:
--   vim.pack.update()  -- update all plugins (`:lua vim.pack.update()`)
--   vim.pack.del(...)  -- remove plugins from disk

local M = {}

--- Expand a 'owner/repo' GitHub slug to a full URL for vim.pack.
---@param repo string
---@return string
function M.gh(repo) return 'https://github.com/' .. repo end

--- Run a plugin build command, notifying on failure.
local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- Build steps that lazy.nvim used to run via `build = ...` now run here,
-- whenever vim.pack installs or updates the relevant plugin.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('config-pack-build', { clear = true }),
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'LuaSnip' then
      -- Build step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

return M

-- vim: ts=2 sts=2 sw=2 et
