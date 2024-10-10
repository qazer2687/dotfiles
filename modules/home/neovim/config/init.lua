vim.cmd("set conceallevel=2")
  vim.cmd("set background=dark")
  --vim.cmd("highlight Normal guibg=black guifg=white")
  vim.cmd("NvimTreeOpen")

  if vim.g.neovide then
    vim.o.guifont = "Agave:h12"
    vim.g.neovide_scale_factor = 0.8

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.g.neovide_transparency = 0.9

    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_theme = 'dark'

    vim.g.neovide_cursor_animation_length = 0.5
    vim.g.neovide_cursor_trail_size = 0.1
  end