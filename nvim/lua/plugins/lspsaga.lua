local function setup_lspsaga()
  require("lspsaga").setup({
    preview = {
      lines_above = 0,
      lines_below = 10,
    },
    scroll_preview = {
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    request_timeout = 2000,
    code_action = {
      num_shortcut = true,
      keys = {
        -- string | table type
        quit = { "q", "<ESC>" },
        exec = "<CR>",
      },
    },
    finder = {
      jump_to = "p",
      edit = "o",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
    },
    rename = {
      quit = "<ESC>",
      exec = "<CR>",
      mark = "m",
      confirm = "<CR>",
      in_select = true,
    },
    outline = {
      win_position = "right",
      -- win_width = 10,
      show_detail = true,
      auto_preview = false,
      auto_refresh = true,
      auto_close = true,
      custom_sort = nil,
      keys = {
        jump = "g",
        expand_collapse = "u",
        quit = "q",
      },
    },
    ui = {
      -- Currently, only the round theme exists
      theme = "round",
      -- This option only works in Neovim 0.9
      title = true,
      -- Border type can be single, double, rounded, solid, shadow.
      border = "rounded",
      winblend = 0,
      expand = "",
      collapse = "",
      preview = " ",
      code_action = "💡",
      diagnostic = "🐞",
      incoming = " ",
      outgoing = " ",
      hover = " ",
      kind = {},
    },
    symbol_in_winbar = {
      enable = false,
      separator = " |> ",
      hide_keyword = true,
      show_file = false,
      folder_level = 2,
      respect_root = true,
      color_mode = true,
    },
  })
end

return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = setup_lspsaga,
  dependencies = { { "kyazdani42/nvim-web-devicons" } },
}
