local buff_ok, bufferline = pcall(require, "bufferline")
if not buff_ok then
  return
end

bufferline.setup({
  options = {
    mode = "tabs",
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 22,
    diagnostics = true,
    offsets = { { filetype = "NvimTree", text = "Files", padding = 1 } },
    separator_style = "thin",
    indicator = {
      style = "icon",
      icon = "",
    },
  },
})
