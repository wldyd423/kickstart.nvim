-- Personal Neovim config, grown from kickstart.nvim.
--
-- Plugins are managed with the built-in plugin manager (`:help vim.pack`,
-- requires nvim 0.12+). Each module under lua/plugins/ installs and configures
-- one area of the setup.
--
-- Load order matters:
--  - leaders must be set before any keymaps/plugins
--  - config.pack must load before any plugin module so its PackChanged
--    autocmd catches build steps on first install
--  - modules that provide dependencies load before their users
--    (ui provides mini.icons/plenary for telescope, lsp provides mason for
--    debug, completion provides blink for 99)

vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'

require 'plugins.colorscheme'
require 'plugins.ui'
require 'plugins.telescope'
require 'plugins.lsp'
require 'plugins.format'
require 'plugins.completion'
require 'plugins.treesitter'
require 'plugins.debug'
require 'plugins.harpoon'
require 'plugins.99'

-- vim: ts=2 sts=2 sw=2 et
