local buff_ok, bufferline = pcall(require, "bufferline")
if (not buff_ok) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    separator_style = "slant",
  },
})

vim.api.nvim_set_keymap('n', '<Tabs>', '<cmd>BufferLineCycleNext<cr>', {})
