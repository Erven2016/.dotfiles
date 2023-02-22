local util = require("lspconfig.util")

local paths = {
  vim.fn.stdpath("config") .. "/spell/ltex.dictionary.en-US.txt",
  vim.fn.expand("%:p:h") .. "/.vscode/ltex.dictionary.en-US.txt",
}

local words = {}
for _, path in ipairs(paths) do
  local f = io.open(path)
  if f then
    for word in f:lines() do
      table.insert(words, word)
    end
    f:close()
  end
end

return function()
  require("lspconfig").ltex.setup({
    filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" },
    root_dir = function(filename)
      return util.path.dirname(filename)
    end,
    settings = {
      ltex = {
        dictionary = {
          ["en-US"] = words,
          ["en-GB"] = words,
        },
      },
    },

    -- paramters: client, bufnr
    on_attach = function()
      -- your other on_attach functions.
      require("ltex_extra").setup({
        load_langs = { "es-AR", "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
        init_check = true, -- boolean : whether to load dictionaries on startup
        path = vim.fn.stdpath("config") .. "/spell", -- string : path to store dictionaries. Relative path uses current working directory
        log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
      })
    end,
  })
end
