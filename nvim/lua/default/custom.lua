local function get_default_shell()
  local system_default_shell = vim.loop.os_uname().sysname == "Windows_NT" and "powershell" or nil

  return vim.fn.executable("nu") and "nu" or system_default_shell
end

local default_config = {
  disabled_lsp = {},
  shell = get_default_shell(),
}

return default_config
