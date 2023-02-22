-- a vscode like winbar
-- url:

local spec = {
  "utilyre/barbecue.nvim",
  version = "*",
  enabled = false, -- disabled temporarily because of E36:Not enough room https://github.com/utilyre/barbecue.nvim/issues/61
  dependencies = {
    "SmiteshP/nvim-navic",
    "kyazdani42/nvim-web-devicons",
  },
}

function spec.config()
  -- triggers CursorHold event faster
  vim.opt.updatetime = 200

  require("barbecue").setup({
    create_autocmd = true,
    show_dirname = false,

    exclude_filetypes = { "gitcommit", "toggleterm", "Trouble", "" },
  })
end

return spec
