local config_path = vim.fn.stdpath("config")

-- Edit config
if vim.fn.filereadable(config_path .. "/init.lua") == 1 then
  vim.api.nvim_create_user_command(
    "EditConfig",
    "cd " .. config_path .. " | " .. "ex " .. config_path,
    { desc = "Open config folder" }
  )
end

-- Export
local M = {}

-- return a string as project name from a path
local function get_session_name(cwd)
  assert(type(cwd) == "string", "require a string")
  local _list = {}

  if vim.loop.os_uname().sysname == "Windows_NT" then
    _list = vim.fn.split(cwd, "\\")
  else
    _list = vim.fn.split(cwd, "/")
  end

  return _list[#_list]
end

-- function mini_sessions
-- to create some user command for session management
-- usage: mini_sessions(require("mini.sessions"))
function M.mini_sessions(sessions)
  -- Create session from current workspace
  vim.api.nvim_create_user_command("CreateSession", function()
    local project_name = get_session_name(vim.fn.getcwd())

    vim.ui.input({ prompt = "Type a typo as session name", default = project_name }, function(input)
      if input ~= nil then
        sessions.write(vim.fn.substitute(input, " ", "_", "g"))
      else
        vim.notify("Failed to write session, user cancled.")
      end
    end)
  end, {
    desc = "Create session for current workspace",
  })

  -- Load session from current workspace
  vim.api.nvim_create_user_command("LoadSession", function()
    sessions.select("read")
  end, {
    desc = "Select a session to load",
  })

  -- Delete Session from detected session
  vim.api.nvim_create_user_command("DeleteSession", function()
    sessions.select("delete")
  end, {
    desc = "Select a session to delete",
  })
end

return M
