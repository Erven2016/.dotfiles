local spec = {
  "voldikss/vim-floaterm",
}

function spec.config()
  local config = require("custom")


  vim.g.floaterm_shell = config.shell

  vim.g.floaterm_position = "center"

  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8
  vim.g.floaterm_autoinsert = false
end

return spec
