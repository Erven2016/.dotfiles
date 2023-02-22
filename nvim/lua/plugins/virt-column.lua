local spec = {
  "lukas-reineke/virt-column.nvim",
}

spec.config = function()
  require("virt-column").setup({
    char = "║",
  })
end

return spec
