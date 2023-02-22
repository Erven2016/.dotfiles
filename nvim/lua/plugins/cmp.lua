-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp

local function setup_nvim_cmp()
  local lspkind = require("lspkind")
  local cmp = require("cmp")

  cmp.setup({
    -- snippet engines
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    -- completion snippet sources
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      -- For vsnip users.
      { name = "vsnip" },
      -- For luasnip users.
      -- { name = 'luasnip' },
      --For ultisnips users.
      -- { name = 'ultisnips' },
      -- -- For snippy users.
      -- { name = 'snippy' },
      { name = "nvim_lua" },
      { name = "emoji" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }),
    -- keymappings
    mapping = require("keybindings").cmp(cmp),
    formatting = {
      format = lspkind.cmp_format({
        with_text = true, -- do not show text alongside icons
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        before = function(entry, vim_item)
          -- Source 显示提示来源
          vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
          return vim_item
        end,
      }),
    },
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return {
  "hrsh7th/nvim-cmp",
  config = setup_nvim_cmp,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-emoji",
  },
}
