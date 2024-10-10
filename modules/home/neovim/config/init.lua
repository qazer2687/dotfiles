vim.cmd("set conceallevel=2")
vim.cmd("set background=dark")
--vim.cmd("highlight Normal guibg=black guifg=white")
vim.cmd("NvimTreeOpen")

-- These options are only used by Neovide.
if vim.g.neovide then
  -- Font
  vim.o.guifont = "Agave:h12"

  -- Scale
  vim.g.neovide_scale_factor = 0.8

  -- Padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Transparency
  vim.g.neovide_transparency = 0.9

  -- Theme
  vim.g.neovide_theme = 'dark'
  
  -- Cursor
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animation_length = 0.5
  vim.g.neovide_cursor_trail_size = 0.1
end