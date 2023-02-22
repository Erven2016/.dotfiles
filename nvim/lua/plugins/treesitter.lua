local function setup()
  local config = {
    enable = true,
    ensure_installed = {
      "html",
      "lua",
      "markdown",
    },
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    },
  }

  require("nvim-treesitter.configs").setup(config)
  require("nvim-treesitter.install").prefer_git = true
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = setup,
}
