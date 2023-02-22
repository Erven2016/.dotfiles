-- lazy.nvim bootstrap from github
-- Proxy may be required in China mainland
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- get latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim")
require("keybindings")
require("hl")
require("user_command")
require("autocmd")

-- load plugins from `lua/plugins/*.lua`
require("lazy").setup("plugins", {
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
  },
})
