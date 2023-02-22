return {
  "j-hui/fidget.nvim",
  config = function()
    local figet = require("fidget")
    local api = vim.api

    api.nvim_set_hl(0, "FidgetTitle", {
      default = true,
      ctermfg = 110,
      fg = "#6cb6eb",
      blend = 0,
    })

    api.nvim_set_hl(0, "FidgetTask", {
      default = true,
      fg = "#606060",
      blend = 0,
    })

    figet.setup({
      text = {
        spinner = "dots",
        done = "✓",
      },
      timer = {
        fidget_decay = 4000,
        task_decay = 2000,
      },
    })
  end,
}
