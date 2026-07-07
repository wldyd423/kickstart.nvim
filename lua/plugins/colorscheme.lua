-- [[ Colorscheme ]]
-- Loaded first among plugins so everything else picks up the right highlights.
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

local gh = require('config.pack').gh

vim.pack.add { gh 'folke/tokyonight.nvim' }

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}

-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'tokyonight-night'

-- vim: ts=2 sts=2 sw=2 et
