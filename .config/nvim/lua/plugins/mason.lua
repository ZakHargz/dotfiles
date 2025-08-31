vim.pack.add {
  { src = "https://github.com/mason-org/mason.nvim" }
}

require "mason".setup()

local registry = require "mason-registry"

local M = {}

M.tools = {}

function M.ensure_installed()
  for _, tool in ipairs(M.tools) do
    if registry.has_package(tool) then
      local pkg = registry.get_package(tool)
      if not pkg:is_installed() then
        vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)
        pkg:install():once("closed", function()
          if pkg:is_installed() then
            vim.notify("Mason: Successfully installed " .. tool, vim.log.levels.INFO)
          else
            vim.notify("Mason: Failed to install " .. tool, vim.log.levels.ERROR)
          end
        end)
      end
    else
      vim.notify("Mason: Package '" .. tool .. "' not found", vim.log.levels.WARN)
    end
  end
end

if registry.refresh then
  registry.refresh(M.ensure_installed)
else
  M.ensure_installed()
end

return M
