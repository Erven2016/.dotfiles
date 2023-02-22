-- use `lir.nvim` to replace netrw

local function setup()
  local actions = require("lir.actions")
  local clipboard_actions = require("lir.clipboard.actions")

  require("lir").setup({
    show_hidden_files = true,
    ignore = {}, -- { ".DS_Store", "node_modules" } etc.
    devicons = {
      enable = true,
      highlight_dirname = true,
    },
    mappings = {
      -- Default key mappings : https://github.com/tamago324/lir.nvim#configuration

      ["<CR>"] = actions.edit,
      ["s"] = actions.split,
      ["v"] = actions.vsplit,
      ["O"] = actions.tabedit,

      ["b"] = actions.up,
      ["q"] = actions.quit,

      ["m"] = actions.mkdir,
      ["c"] = actions.newfile,
      ["r"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["."] = actions.toggle_show_hidden,
      ["d"] = actions.delete,

      ["y"] = clipboard_actions.copy,
      ["x"] = clipboard_actions.cut,
      ["p"] = clipboard_actions.paste,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = false,
        highlight_dirname = false,
      },
    },
    hide_cursor = true,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "lir" },
    callback = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )

      -- echo cwd
      vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
    end,
  })

  -- custom folder icon
  require("nvim-web-devicons").set_icon({
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode",
    },
  })
end

return {
  "tamago324/lir.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
  },
  config = setup,
}
