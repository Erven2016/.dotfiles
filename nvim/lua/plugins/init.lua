local lsp_setup = require("lsp.setup")

return {
  {
    "williamboman/mason.nvim",
    config = lsp_setup.mason,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = lsp_setup.mason_lspconfig,
  },
  {
    "neovim/nvim-lspconfig",
    config = lsp_setup.nvim_lspconfig,
  },
  {
    "barreiroleo/ltex-extra.nvim",
  }, -- to fix not working functions of ltex-ls like addToDictionary, disableRule, hideFalsePositive
}
