local legend_status, legendary = pcall(require, "legendary")
if not legend_status then
	return
end

legendary.setup({
	include_builtin = true,
})
