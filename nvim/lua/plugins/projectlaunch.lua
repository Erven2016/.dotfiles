local spec = {
  "sheodox/projectlaunch.nvim",
  -- dir = "C:\\Users\\leigu\\Projects\\projectlaunch.nvim",
}

function spec.config()
  local projectlaunch = require("projectlaunch")
  projectlaunch.setup({
    -- set a default width for split windows
    split_default_width = 80,
    -- if opening the split terminal should move focus to the split's window
    split_focus_on_open = false,
    -- the filename of configuration file which under root directory.
    config_path = "project.json",
    -- automatically reload config after loading a session or updating your ProjectLaunch config file
    auto_reload_config = true,
  })
end

return spec
