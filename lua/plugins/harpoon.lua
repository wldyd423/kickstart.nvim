-- [[ Harpoon ]]
-- Quick file bookmarks. Selects live on <M-...> so the <C-hjkl> window
-- navigation keymaps (config/keymaps.lua) keep working.

local gh = require('config.pack').gh

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: [a]dd file' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: quick menu' })
vim.keymap.set('n', '<M-h>', function() harpoon:list():select(1) end, { desc = 'Harpoon: select 1' })
vim.keymap.set('n', '<M-t>', function() harpoon:list():select(2) end, { desc = 'Harpoon: select 2' })
vim.keymap.set('n', '<M-n>', function() harpoon:list():select(3) end, { desc = 'Harpoon: select 3' })
vim.keymap.set('n', '<M-s>', function() harpoon:list():select(4) end, { desc = 'Harpoon: select 4' })

-- vim: ts=2 sts=2 sw=2 et
