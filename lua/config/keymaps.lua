-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
if vim.fn.executable("gitui") == 1 then
  -- gitui instead of lazygit
  vim.keymap.set("n", "<leader>gG", function()
    require("lazyvim.util").float_term({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
  end, { desc = "gitui (cwd)" })
  vim.keymap.set("n", "<leader>gg", function()
    require("lazyvim.util").float_term(
      { "gitui" },
      { cwd = require("lazyvim.util").get_root(), esc_esc = false, ctrl_hjkl = false }
    )
  end, { desc = "gitui (root dir)" })
end
--
-- if vim.fn.executable("btop") == 1 then
--   -- btop
--   vim.keymap.set("n", "<leader>xb", function()
--     require("lazyvim.util").float_term({ "btop" }, { esc_esc = false, ctrl_hjkl = false })
--   end, { desc = "btop" })
-- end
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }

-- Space as leader
-- map("n", "<Space>", "", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
-- map('n', '<C-Space>', '<cmd>WhichKey \\<leader><cr>', opts)
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
map("n", "<Tab>", "<cmd>Telescope buffers<cr>", opts)
map("n", "<S-Tab>", "za", opts)
map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
-- map("n", "<C-g>", "<cmd>LazygitToggle<cr>", opts)
map("n", "<C-b>", "<Home>", opts)
map("n", "<C-e>", "<End>", opts)
map("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("i", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("t", "<C-\\>", "<cmd>ToggleTerm<CR>", opts)
-- ["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
-- Use jj as escape
map("i", "jj", "<Esc>", opts)
map("i", "<C-c>", "<Esc>", opts)
--Move cursor insert mode
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-h>", "<BS>", opts)
map("i", "<C-f>", "<Right>", opts)
map("i", "<C-b>", "<Left>", opts)
map("i", "<C-a>", "<Home>", opts)
map("i", "<C-e>", "<End>", opts)
map("i", "<C-d>", "<Del>", opts)

-- Resize windows
map("n", "<Up>", "<cmd>resize +1<cr>", { desc = "Resize Window" })
map("n", "<Down>", "<cmd>resize -1<cr>", { desc = "Resize Window" })
map("n", "<Left>", "<cmd>vertical resize +1<cr>", { desc = "Resize Window" })
map("n", "<Right>", "<cmd>vertical resize -1<cr>", { desc = "Resize Window" })
-- Use backspace key for matching parens
map({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

-- Background dark/light toggle
-- map('n', '<leader>tt', function()
--     if vim.o.background == 'dark' then
--         vim.o.background = 'light'
--     else
--         vim.o.background = 'dark'
--     end
-- end, { desc = 'Toggle background dark/light' })
-- Modes
--   normal_mode = "n" ,
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
map("n", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<CR>" or "za"
end, { expr = true, desc = "Toggle Fold" })
-- Focus the current fold by closing all others
map("n", "<S-Return>", "zMzv", { remap = true, desc = "Focus Fold" })
-- Start new line from any cursor position in insert-mode
map("i", "<S-Return>", "<C-o>o", { desc = "Start Newline" }) -- Macros
map("n", "<C-q>", "q", { desc = "Macro Prefix" })
-- Delete a word backwards
-- map('n', 'dw', 'vb"_d', opts)
-- Drag current line/s vertically and auto-indent
map("n", "<A-k>", "<cmd>move-2<CR>==", { desc = "Move line up" })
map("n", "<A-j>", "<cmd>move+<CR>==", { desc = "Move line down" })
map("x", "<A-k>", ":move'<-2<CR>gv=gv", { desc = "Move selection up" })
map("x", "<A-j>", ":move'>+<CR>gv=gv", { desc = "Move selection down" })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map("n", "<A-d>", 'm`""Y""P``', { desc = "Duplicate line" })
map("x", "<A-d>", '""Y""Pgv', { desc = "Duplicate selection" })
-- Switch */g* and #/g#
map("n", "*", "g*")
map("n", "g*", "*")
map("n", "#", "g#")
map("n", "g#", "#")
-- Duplicate paragraph
map("n", "<Leader>cp", "yap<S-}>p", { desc = "Duplicate Paragraph" })
-- I hate typing these
-- map("v", "H", "^", opts)
-- map("n", "B", "^", opts)
-- map("n", "E", "$", opts)
-- map("v", "L", "$", opts)
-- map("x", "H", "^", opts)
-- map("x", "L", "$", opts)
-- map("o", "H", "^", opts)
-- map("o", "L", "$", opts)

-- Hop
map("n", "sw", "<cmd>HopWordMW<cr>", { desc = "jump: Goto word" })
map("n", "<leader>j", "<cmd>HopLineMW<cr>", { desc = "jump: Goto line" })
map("n", "sc", "<cmd>HopChar2MW<cr>", { desc = "jump: Goto one charater" })
map("v", "p", '"_dP', opts)
map("i", "<C-v>", "<C-o>P", opts)

-- Do not copy on x
map("n", "x", '"_x', opts)
map("n", "ml", "<cmd>Telescope bookmarks list<cr>", opts)

-- Increment/decrement
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- New tab
map("n", "te", ":tabedit ", opts)
-- Split window
map("n", "ts", ":split ", opts)
map("n", "tv", ":vsplit ", opts)

-- Switch window
map("n", "tw", "<C-w>w", opts)
map("", "th", "<C-w>h", opts)
map("", "tk", "<C-w>k", opts)
map("", "tj", "<C-w>j", opts)
map("", "tl", "<C-w>l", opts)
map("", "tq", "<cmd>:q<cr>", opts)

-- alt binds
map("n", "<m-s>", "<cmd>split<cr>", opts)
map("n", "<m-v>", "<cmd>vsplit<cr>", opts)
map("n", "<m-q>", "<cmd>:q<cr>", opts)

-- open link under cursor
map("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

-- Center Cursors
map("n", "J", "mzJ`z", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Search and replace
-- map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
map("n", "sr", '<cmd>lua require("spectre").open_file_search()<CR>', opts)
map("n", "sR", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', opts)

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Switch buffers
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Clear search, diff update and redraw
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Search word under cursor
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>w<tab>", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w\\", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>\\", "<C-W>v", { desc = "Split window right" })

