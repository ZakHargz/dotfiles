local status, bufferline = pcall(require, "barbar")
if not status then
	return
end

bufferline.setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	closeable = false,
	clickable = true,
	exclude_ft = { "qf" },
	icons = "both",
	icon_custom_colors = false,
	icon_separator_active = "▎",
	icon_separator_inactive = "▎",
	icon_close_tab = "",
	icon_close_tab_modified = "●",
	icon_pinned = "車",
	insert_at_end = false,
	maximum_padding = 2,
	maximum_length = 30,
	semantic_letters = true,
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
	no_name_title = nil,
})
