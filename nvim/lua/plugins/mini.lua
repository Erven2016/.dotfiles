local spec = {
  "echasnovski/mini.nvim",
  version = "*",
  dependencies = {},
}

-- starter menu items
local starter_items = function(sections)
  local menu = {
    sections.sessions(5, true),
  }

  local function gen_name(key, typo)
    if key ~= "" then
      return tostring(key) .. " | " .. tostring(typo)
    else
      return ". " .. typo
    end
  end

  local section_start = {
    { name = gen_name("ff", "find files"), action = "Telescope find_files", section = "Start" },
    { name = gen_name("fm", "file manager"), action = "Telescope file_browser", section = "Start" },
    { name = gen_name("fh", "history files"), action = "Telescope oldfiles", section = "Start" },
    { name = gen_name("fn", "new file"), action = "enew", section = "Start" },
  }

  local section_settings = {
    { name = gen_name("lu", "upgrade plugins"), action = "Lazy sync", section = "Settings" },
    { name = gen_name("lp", "startup time analysis"), action = "Lazy profile", section = "Settings" },
    { name = gen_name("lm", "mason installer"), action = "Mason", section = "Settings" },
    { name = gen_name("lc", "edit config"), action = "EditConfig", section = "Settings" },
  }

  local section_other = {
    { name = gen_name("qq", "quitting neovim"), action = "qa!", section = "Other" },
  }

  vim.list_extend(menu, section_start)
  vim.list_extend(menu, section_settings)
  vim.list_extend(menu, section_other)

  return menu
end

function spec.config()
  -- detect and create session folder
  local session_path = vim.fn.stdpath("data") .. "/session"
  if vim.fn.isdirectory(session_path) == 0 then
    vim.fn.mkdir(session_path)
  end

  -- If autowrite is not working then please check here
  -- Command is failed to run in sometime.
  local function write_pre_hooks()
    local cmd = vim.cmd

    -- close aerial.nvim
    cmd("AerialClose")

    -- TODO: close all termianl before write session
  end

  require("mini.sessions").setup({
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,
    -- Whether to write current session before quitting Neovim
    autowrite = true,
    -- File for local session (use `''` to disable)
    file = "Session.vim",
    -- Whether to force possibly harmful actions (meaning depends on function)
    force = { read = false, write = true, delete = true },
    -- Hook functions for actions. Default `nil` means 'do nothing'.
    hooks = {
      -- Before successful action
      pre = { read = nil, write = write_pre_hooks, delete = nil },
      -- After successful action
      post = { read = nil, write = nil, delete = nil },
    },
    -- Whether to print session path after action
    verbose = { read = false, write = true, delete = true },
  })

  -- improve mini_sessions experience
  local session_user_cmd = require("user_command").mini_sessions
  session_user_cmd(require("mini.sessions"))

  require("mini.starter").setup({
    -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
    -- started with intent to show something else.
    autoopen = true,

    -- Whether to evaluate action of single active item
    evaluate_single = false,

    -- Items to be displayed. Should be an array with the following elements:
    -- - Item: table with <action>, <name>, and <section> keys.
    -- - Function: should return one of these three categories.
    -- - Array: elements of these three types (i.e. item, array, function).
    -- If `nil` (default), default items will be used (see |mini.starter|).
    items = starter_items(require("mini.starter").sections),

    -- Header to be displayed before items. Converted to single string via
    -- `tostring` (use `\n` to display several lines). If function, it is
    -- evaluated first. If `nil` (default), polite greeting will be used.
    header = nil,

    -- Footer to be displayed after items. Converted to single string via
    -- `tostring` (use `\n` to display several lines). If function, it is
    -- evaluated first. If `nil` (default), default usage help will be shown.
    footer = "",

    -- Array of functions to be applied consecutively to initial content.
    -- Each function should take and return content for 'Starter' buffer (see
    -- |mini.starter| and |MiniStarter.content| for more details).
    content_hooks = nil,

    -- Characters to update query. Each character will have special buffer
    -- mapping overriding your global ones. Be careful to not add `:` as it
    -- allows you to go into command mode.
    query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
  })
end

return spec
