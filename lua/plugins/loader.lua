local M = {}

local uv = vim.uv or vim.loop

function M.load(folder)
  local base = vim.fn.stdpath("config") .. "/lua/plugins/" .. folder
  local fd = uv.fs_scandir(base)

  if not fd then return end

  while true do
    local name, type = uv.fs_scandir_next(fd)
    if not name then break end

    if type == "file" and name:match("%.lua$") then
      local module = ("plugins.%s.%s"):format(
        folder,
        name:gsub("%.lua$", "")
      )

      require(module)
    end
  end
end

return M
