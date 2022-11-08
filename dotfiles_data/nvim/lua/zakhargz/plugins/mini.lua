local mini_starter, starter = pcall(require, "mini.starter")
if not mini_starter then
	return
end

starter.setup({
	autoopen = true,
	evaluate_single = false,
	header = nil,
	footer = "",
	query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
})
