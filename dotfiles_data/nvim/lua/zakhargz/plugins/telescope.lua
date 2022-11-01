local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local telescope_actions, actions = pcall(require, "telescope.actions")
if not telescope_actions then
	return
end

telescope.setup({
	defaults = {
		layout_strategy = "flex",
		layout_config = {
			flex = {
				flip_columns = 180,
			},
		},
		file_ignore_patterns = { "node_modules", ".git/" },
		path_display = { "truncate" },
		mappings = {
			i = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
			},
			n = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		live_grep = {
			additional_args = function()
				return { "--hidden" }
			end,
		},
		find_files = {
			hidden = true,
		},
		lsp_references = {
			layout_strategy = "vertical",
		},
	},
	extensions = {
		["ui-select"] = require("telescope.themes").get_cursor({
			initial_mode = "normal",
		}),
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
