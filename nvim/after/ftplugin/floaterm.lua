-- set keymap for buffer of floaterm

local map = function(mode, key, action, opts)
  vim.api.nvim_buf_set_keymap(0, mode, key, action, opts)
end

local opts = {
  noremap = true,
  silent = true,
}

-- these keymappings only avaliable in floaterm
map("n", "n", "<CMD>FloatermNew<CR>", opts) -- create a new floaterm
map("n", "c", "<CMD>FloatermKill<CR>", opts) -- close current floaterm
map("n", "q", "<CMD>FloatermHide<CR>", opts) -- hide the floaterm
map("n", ",", "<CMD>FloatermPrev<CR>", opts) -- go to the previous floaterm
map("n", ".", "<CMD>FloatermNext<CR>", opts) -- go to the next floaterm
map("n", "<", "<CMD>FloatermFirst<CR>", opts) -- go to the first floaterm
map("n", ">", "<CMD>FloatermLast<CR>", opts) -- go to the last floaterm
