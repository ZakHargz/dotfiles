local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode", "branch" },
		lualine_b = {
			{
				"filename",
				file_status = true,
				path = 1,
				short_target = 40,
				symbols = {
					modified = " * ",
					readonly = "  ",
					unnamed = "[No Name]",
				},
			},
		},
		lualine_c = {
			"CurrentFunction",
			{
				"diff",
				colored = true,
				diff_color = {
					added = "DiffAdd",
					modified = "DiffChanged",
					removed = "DiffDelete",
				},
				symbols = { added = "+", modified = "*", removed = "-" },
				source = nil,
			},
			{
				"lsp_progress",
				-- With spinner
				separators = {
					component = " ",
					progress = " | ",
					percentage = { pre = "", post = "%% " },
					title = { pre = "", post = ": " },
					lsp_client_name = { pre = "[", post = "]" },
					spinner = { pre = "", post = "" },
					message = { commenced = "In Progress", completed = "Completed", pre = "(", post = ")" },
				},
				display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
				timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic", "nvim_lsp", "vim_lsp" },
				selections = { "error", "warn", "info", "hint" },
				diagnostics_color = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
				symbols = { error = " ⊗ ", warn = "⚠ ", info = "🛈 ", hint = " " },
				colored = true,
				update_in_insert = false,
				always_visible = false,
			},
		},
		lualine_y = { "location" },
		lualine_z = { "encoding", "filetype" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
