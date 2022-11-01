local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neotree.setup({
	close_if_last_window = true,
	enable_diagnostics = false,
	source_selector = {
		winbar = true,
		content_layout = "center",
		tab_labels = {
			filesystem = "Files",
			buffers = "Bufs",
			git_status = "Git",
			diagnostics = "Diagnostics",
		},
	},
	window = {
		width = 30,
		mappings = {
			["o"] = "open",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behaviour = "open_current",
		use_libuv_file_watcher = true,
	},
})
