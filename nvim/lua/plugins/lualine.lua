local spec = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
}

function spec.config()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "|", right = "|" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {
        "lazy",
      },
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },

    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics", "searchcount" },
      lualine_c = { "hostname" },
      lualine_x = {
        function()
          return " " .. tostring(os.date("%H:%M"))
        end,
        function()
          return "󰍛 " .. string.format("%.2fG", tostring(vim.loop.get_free_memory() / 1024 ^ 3))
        end,
        {
          "overseer",
          colored = false,
          unique = true,
        },
      },
      lualine_y = {
        "filetype",
        "filesize",
        "encoding",
        {
          "fileformat",
          symbols = {
            -- diff eol in different systems
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
        "progress",
      },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },

    -- winbar = {},
    -- inactive_winbar = {},

    extensions = {},
  })
end

return spec
