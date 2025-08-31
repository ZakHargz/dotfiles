local plugin_dir = vim.fn.stdpath("config") .. "/lua/languages"

for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
  if file:sub(-4) == ".lua" and file ~= "init.lua" then
    local module = "languages." .. file:sub(1, -5)
    require(module)
  end
end
