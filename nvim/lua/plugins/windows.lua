local spec = {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
}

function spec.config()
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = false

  require("windows").setup({
    ignore = {
      buftype = { "quickfix", "aerial" },
      filetype = { "aerial" },
    },
  })
end

return spec
