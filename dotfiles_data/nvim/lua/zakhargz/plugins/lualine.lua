local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

local navic = require("nvim-navic")
local function gps_content()
	if navic.is_available() then
		return navic.get_location()
	else
		return ""
	end
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#1793d1",
	red = "#ec5f67",
}

local conf = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = "|",
		disabled_filetypes = {},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = { statusline = 1000 },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename", "lsp_progress" },
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
}

local function ins_left(component)
	table.insert(conf.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(conf.sections.lualine_x, component)
end

ins_left({ gps_content, cond = navic.is_available })
ins_right({
	function()
		local msg = "No Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		msg = ""
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				msg = msg .. " " .. client.name
			end
		end
		msg = string.gsub(msg, "^%s*(.-)%s*$", "%1")
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.red },
})

lualine.setup(conf)
