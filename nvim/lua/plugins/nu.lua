local spec = {
  "LhKipp/nvim-nu",
  -- ft = {"conf", "nu"},
}

spec.config = function()
  require("nu").setup({
    use_lsp_features = false,
  })
end

return spec
