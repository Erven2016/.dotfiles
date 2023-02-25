local lsp_format = {
  function()
    vim.lsp.buf.format()
  end,
}

return {
  "mhartington/formatter.nvim",
  config = function()
    -- local util = require "formatter.util"

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup({
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
          -- "formatter.filetypes.lua" defines default configurations for the
          -- "lua" filetype
          require("formatter.filetypes.lua").stylua,
        },

        rust = {
          require("formatter.filetypes.rust").rustfmt,
        },

        markdown = {
          require("formatter.filetypes.markdown").prettier,
        },

        yaml = {
          require("formatter.filetypes.markdown").prettier,
        },

        python = lsp_format,

        html = {
          require("formatter.filetypes.html").prettier,
        },

        json = {
          require("formatter.filetypes.json").prettier,
        },

        css = {
          require("formatter.filetypes.css").prettier,
        },

        scss = {
          require("formatter.filetypes.css").prettier,
        },

        less = {
          require("formatter.filetypes.css").prettier,
        },

        typescript = {
          require("formatter.filetypes.typescript").prettier,
        },

        javascript = {
          require("formatter.filetypes.javascript").prettier,
        },

        nu = lsp_format,
        toml = lsp_format,

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        -- ["*"] = {},
      },
    })
  end,
}
