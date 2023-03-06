local M = {}

M.mason = function()
  require("mason").setup({
    ui = {
      border = "rounded",
      width = 0.8,
      height = 0.8,
    },
  })
end

M.nvim_lspconfig = function() end

M.mason_lspconfig = function()
  -- stared lsps but will not install automatically on arm64: letx
  local ensure_installed_lsp = { "rust_analyzer", "lua_ls", "pylsp" }

  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed_lsp,
    automatic_installation = true,
  })

  require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      local status, config = pcall(require, "lsp." .. server_name)

      if status then
        -- if config file is exist then import, if not then using blank config
        if type(config) == "function" then
          config()
        end
        if type(config) == "table" then
          require("lspconfig")[server_name].setup(config)
        end
      else
        require("lspconfig")[server_name].setup({})
      end
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function()
    -- 	require("rust-tools").setup({})
    -- end,
  })
end

return M
