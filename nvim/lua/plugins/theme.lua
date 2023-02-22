return {
  "projekt0n/github-nvim-theme",
  config = function()
    require("github-theme").setup({
      theme_style = "dark_default",
      function_style = "italic",
      sidebars = { "qf", "vista_kind", "terminal", "packer" },
      transparent = false,

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      -- colors = { hint = "orange", error = "#ff0000" },

      -- Overwrite the highlight groups
      overrides = function()
        return {}
      end,
    })
  end,
  -- set lazy to false and set priority to a high number for colorschemes.
  lazy = false,
  priority = 1000,
}
