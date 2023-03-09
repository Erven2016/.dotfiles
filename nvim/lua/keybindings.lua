-- local fn, loop = vim.fn, vim.loop
local cmd = vim.cmd

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- modes
local mode = {
  normal = "n",
  insert = "i",
  visual = "v",
  visual_block = "x",
  terminal = "t",
  command = "c",
}

-- default options
local opt = {
  noremap = true,
  silent = true,
}

-- Function: to create a keymapping
-- usage: map(mode, key, action, opt)
-- paramters:
-- - mode:		string|table			vim modes
-- - key:			string|table			items of table must be string
-- - action:	string|function		cmd or function to run
-- - opt:			table							opt of function `vim.keymap.set`
local map = function(_mode, _key, action, _opt)
  if type(_key) == "table" then
    for i = 1, #_key, 1 do
      local key = _key[i]
      assert(type(key) == "string", "keys in table must be string")
      vim.keymap.set(_mode, _key[i], action, _opt)
    end
  end
  if type(_key) == "string" then
    vim.keymap.set(_mode, _key, action, _opt)
  end
end

-- !DisabledKeys
map({ mode.normal, mode.visual, mode.visual_block }, "K", "<nop>", opt)

-- *EditerFeatureExpand
map(mode.normal, "<leader>m", "<CMD>Telescope marks<CR>", opt) -- toggle marks list
map(mode.normal, "fc", "<CMD>Telescope commands<CR>", opt) -- toggle command list

-- *File
map(mode.normal, "ff", "<CMD>Telescope find_files<CR>", opt) -- find file in current workspace
map(mode.normal, "fz", "<CMD>Telescope current_buffer_fuzzy_find<CR>", opt) -- fuzzy find buffer content
map(mode.normal, "fm", "<CMD>Telescope file_browser<CR>", opt) -- file manager (Telescope provides)

-- *Terminal
map(mode.terminal, "<A-`>", "<C-\\><C-n>", opt) -- quit terminal mode
map(mode.normal, "<C-\\>", "<CMD>FloatermToggle<CR>", opt) -- toggle floaterm
-- TODO: use command `FloatermSend` to run current line in terminal

-- *Git
map(mode.normal, "gs", "<CMD>Telescope git_status<CR>", opt)
map(mode.normal, "gS", "<CMD>Telescope git_stash<CR>", opt)
map(mode.normal, "gb", "<CMD>Telescope git_branches<CR>", opt)
map(mode.normal, "gl", function()
  if vim.fn.executable("lazygit") == 1 then
    cmd("FloatermNew --name=Lazygit --title=Lazygit lazygit")
  else
    vim.notify("Lazygit is not installed.")
  end
end, opt)

-- *CodeActions
map(mode.normal, "<TAB>", "<CMD>Lspsaga code_action<CR>", opt) -- code action in current line
map(mode.normal, "<F2>", "<CMD>Lspsaga rename<CR>", opt) -- rename variable/function
map(mode.normal, "<A-F2>", "<CMD>Lspsaga rename ++project<CR>", opt) -- rename variable/function for the selected files
map(mode.normal, { "<A-f>", "c=" }, "<CMD>Format<CR>", opt) -- format code

-- *CodeDocument&Reference
map(mode.normal, "K", "<CMD>Lspsaga hover_doc<CR>", opt) -- show hover document
map(mode.normal, "<A-K>", "<CMD>Lspsaga peek_definition<CR>", opt) -- show peek definition
map(mode.normal, "<A-F>", "<CMD>Lspsaga lsp_finder<CR>", opt) -- open lsp finder
map(mode.normal, "<A-o>", "<CMD>AerialToggle!<CR>", opt) -- toggle code outline
map(mode.normal, "gd", "<CMD>Lspsaga goto_definition<CR>", opt) -- goto code defined location

-- *Diagnostic
map(mode.normal, "[e", "<CMD>Lspsaga diagnostic_jump_prev<CR>", opt) -- jump to previous diagnostic
map(mode.normal, "]e", "<CMD>Lspsaga diagnostic_jump_next<<CR>", opt) -- jump to next diagnostic
map(mode.normal, "<A-d>", "<CMD>Lspsaga show_line_diagnostics<CR>", opt) -- show diagnostic of current line
map(mode.normal, "<A-c>", "<CMD>Lspsaga show_cursor_diagnostics<CR>", opt) -- show diagnostic of cursor
map(mode.normal, "<A-x>", "<CMD>Lspsaga show_buf_diagnostics<CR>", opt) -- show diagnostic of current buffer
map(mode.normal, "<A-X>", "<CMD>Telescope diagnostics<CR>", opt) -- show diagnostic of all buffers

-- *Buffers
map(mode.normal, "fb", "<CMD>Telescope buffers<CR>", opt) -- find buffer via Telescope
map(mode.normal, "<A-,>", "<Cmd>BufferPrevious<CR>", opt) -- switch to prev buffer
map(mode.normal, "<A-.>", "<Cmd>BufferNext<CR>", opt) -- switch to next buffers
-- Re-order to previous/next
map(mode.normal, "<A-<>", "<Cmd>BufferMovePrevious<CR>", opt) -- move buffer to previous position of tabline
map(mode.normal, "<A->>", "<Cmd>BufferMoveNext<CR>", opt) -- move buffer to next position of tabline
-- Goto buffer in position...
map(mode.normal, "<A-1>", "<Cmd>BufferGoto 1<CR>", opt)
map(mode.normal, "<A-2>", "<Cmd>BufferGoto 2<CR>", opt)
map(mode.normal, "<A-3>", "<Cmd>BufferGoto 3<CR>", opt)
map(mode.normal, "<A-4>", "<Cmd>BufferGoto 4<CR>", opt)
map(mode.normal, "<A-5>", "<Cmd>BufferGoto 5<CR>", opt)
map(mode.normal, "<A-6>", "<Cmd>BufferGoto 6<CR>", opt)
map(mode.normal, "<A-7>", "<Cmd>BufferGoto 7<CR>", opt)
map(mode.normal, "<A-8>", "<Cmd>BufferGoto 8<CR>", opt)
map(mode.normal, "<A-9>", "<Cmd>BufferGoto 9<CR>", opt)
map(mode.normal, "<A-0>", "<Cmd>BufferLast<CR>", opt) -- switch to the last buffer
map(mode.normal, "<A-p>", "<Cmd>BufferPin<CR>", opt) -- pin/unpin a buffer
map(mode.normal, "<A-C>", "<Cmd>BufferClose<CR>", opt) -- close current buffer
map(mode.normal, "<A-:>", "<CMD>BufferCloseBuffersLeft<CR>", opt) -- close buffers in the left of current buffer
map(mode.normal, '<A-">', "<CMD>BufferCloseBuffersRight<CR>", opt) -- close buffers in the right of current buffer
map(mode.normal, "<leader>bm", "<CMD>Telescope buffers<CR>") -- show buffer list
map(mode.normal, "<leader>bo", "<CMD>BufferCloseAllButCurrent<CR>", opt) -- close other buffers
map(mode.normal, "<C-p>", "<Cmd>BufferPick<CR>", opt) -- magic buffer-picking mode
-- Sort automatically by...
map(mode.normal, "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opt) -- buffer number
map(mode.normal, "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opt) -- directory
map(mode.normal, "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opt) -- language
map(mode.normal, "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opt) -- window number

-- *Session
map(mode.normal, "<leader>sw", "<CMD>CreateSession<CR>", opt) -- Create a session for current workspace
map(mode.normal, "<leader>sl", "<CMD>LoadSession<CR>", opt) -- load a session form existed sessions
map(mode.normal, "<leader>sd", "<CMD>DeleteSession<CR>", opt) -- delete a session from existed sessions

-- #Telescope
map(mode.normal, "<F12>", "<CMD>Telescope<CR>", opt) -- open Telescope menu

-- #Projectlaunch
map(mode.normal, "<leader>p", "<CMD>lua require('projectlaunch').toggle_main_menu()<CR>", opt)

-- #TodoComment
map(mode.normal, "[c", function()
  require("todo-comments").jump_prev()
end, opt) -- prev todo comment
map(mode.normal, "]c", function()
  require("todo-comments").jump_next()
end, opt) -- next todo comment
map(mode.normal, "<leader>tc", function()
  -- check if rg executable is installed
  if vim.fn.executable("rg") == 1 then
    cmd("TodoTelescope")
  else
    vim.notify("ripgrep is not installed!")
  end
end, opt) -- toggle list of todo comments in project

-- windows.nvim shortcut
map(mode.normal, "<C-w>=", "<CMD>WindowsEqualize<CR>", opt) -- equalize windows
map(mode.normal, "<C-w>m", "<CMD>WindowsMaximize<CR>", opt) -- maximize windows
map(mode.normal, "<C-w>\\", "<CMD>WindowsMaximizeVertically<CR>", opt) -- maximize window vertically
map(mode.normal, "<C-w>/", "<CMD>WindowsMaximizeHorizontally<CR>", opt) -- maximize window horizontally

-- *** Export Keybindings ***
local M = {}

M._module = {}

M._module.map = map
M._module.mode = mode
M._module.opt = opt

-- nvim-cmp
M.cmp = function(cmp)
  return {
    -- Previous suggestion
    ["<A-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    -- Next suggestion
    ["<A-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    -- open float window of auto-complete
    ["<A-,>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- close float window of auto-complete
    ["<A-.>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- enter
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- scroll up doc 4 lines
    ["<A-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    -- scroll down doc 4 lines
    ["<A-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  }
end

-- #gitsigns
-- M.gitsigns = function ()
--
-- end

return M
