local function setup()
  local extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- default key mappings : https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  }

  require("telescope").setup({
    defaults = {
      -- setup .gitignore is useful to hide file in find_file picker
      file_ignore_patterns = {
        "^after/",
        "^node_modules/",
        "^build/",
        "^target/",
        "^spell/",
      },
      -- mapping = require("keybindings").telescope(),
      picker = {},
      extensions = extensions,
    },
  })

  require("telescope").load_extension("file_browser")
end

return {
  "nvim-telescope/telescope.nvim",
  config = setup,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "LinArcX/telescope-env.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
}
