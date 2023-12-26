local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local icons = require("config.icons")

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    ["<leader>"] = icons.ui.Rocket .. "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = icons.ui.ArrowOpen, -- symbol used in the command line area that shows your active key combo
    separator = icons.ui.Arrow, -- symbol used between a key and it's label
    group = "", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 15,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually
  -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  },
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "j" },
    v = { "j", "j" },
  },
}

local i = {
  [" "] = "Whitespace",
  ['"'] = 'Balanced "',
  ["'"] = "Balanced '",
  ["`"] = "Balanced `",
  ["("] = "Balanced (",
  [")"] = "Balanced ) including white-space",
  [">"] = "Balanced > including white-space",
  ["<lt>"] = "Balanced <",
  ["]"] = "Balanced ] including white-space",
  ["["] = "Balanced [",
  ["}"] = "Balanced } including white-space",
  ["{"] = "Balanced {",
  ["?"] = "User Prompt",
  _ = "Underscore",
  a = "Argument",
  b = "Balanced ), ], }",
  c = "Class",
  f = "Function",
  o = "Block, conditional, loop",
  q = "Quote `, \", '",
  t = "Tag",
}

local a = vim.deepcopy(i)
for k, v in pairs(a) do
  a[k] = v:gsub(" including.*", "")
end

local ic = vim.deepcopy(i)
local ac = vim.deepcopy(a)

for key, name in pairs({ n = "Next", l = "Last" }) do
  i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
  a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local wk = require("which-key")
wk.register({
  sw = "Goto word",
  sj = "Go to line",
  sc = "Go to 2 characters",
  sr = "Search current word in file",
  sR = "Search current word in project",
  tF = "Find left surrounding",
  sf = "Find right surrounding",
  st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
})
local mappings = {
  -- ["e"] = { "<cmd>NvimTreeToggle<cr>", icons.documents.OpenFolder .. "Explorer" },
  ["x"] = { "<cmd>x<cr>", icons.ui.Pencil .. "Write and Quit" },
  ["q"] = { "<cmd>bw<cr>", icons.ui.Close .. "Close Buffer" },
  ["Q"] = { "<cmd>qa!<cr>", icons.ui.Power .. "Force Quit!" },
  c = {
    name = icons.ui.Vim .. "Config",
    c = { "<cmd>:g/^\\s*$/d<cr>", "Clean Empty Lines" },
    e = { "<cmd>e $MYVIMRC<cr>", "Edit Config" },
    -- f = { '<cmd>!eslint --fix %<cr>', 'Format Files' },
    F = { "<cmd>retab<cr>", "Fix Tabs" },
    i = { vim.show_pos, "Inspect Position" },
    n = { "<cmd>set relativenumber!<cr>", "Relative Numbers" },
    N = { "<cmd>Telescope notify<cr>", "Notifications" },
    r = { "<cmd>Telescope reloader<cr>", "Reload Module" },
    R = { "<cmd>ReloadConfig<cr>", "Reload Configs" },
    s = { "<cmd>%SnipRun<cr>", "Run File" },
    y = { "<cmd>CRpath<cr>", "Copy Relative Path" },
    Y = { "<cmd>CApath<cr>", "Copy Absolute Path" },
    p = {
      name = icons.ui.Package .. "Packages",
      c = { "<cmd>Lazy check<cr>", "Check" },
      d = { "<cmd>Lazy debug<cr>", "Debug" },
      h = { "<cmd>Lazy<cr>", "Plugins" },
      i = { "<cmd>Lazy install<cr>", "Install" },
      l = { "<cmd>Lazy log<cr>", "Log" },
      m = { "<cmd>Mason<cr>", "Mason" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      r = { "<cmd>Lazy restore<cr>", "Restore" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      u = { "<cmd>Lazy update<cr>", "Update" },
      x = { "<cmd>Lazy clean<cr>", "Clean" },
    },
  },
  d = {
    name = icons.ui.Bug .. "Debug",
    b = { "<cmd>DapToggleBreakpoint<cr>", "Breakpoint" },
    c = { "<cmd>DapContinue<cr>", "Continue" },
    i = { "<cmd>DapStepInto<cr>", "Into" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    o = { "<cmd>DapStepOver<cr>", "Over" },
    O = { "<cmd>DapStepOut<cr>", "Out" },
    r = { "<cmd>DapToggleRepl<cr>", "Repl" },
    R = { "<cmd>DapRestartFrame<cr>", "Restart Frame" },
    t = { "<cmd>DapUIToggle<cr>", "Debugger" },
    x = { "<cmd>DapTerminate<cr>", "Exit" },
  },
  D = {
    name = icons.ui.Database .. "Database",
    b = { "<cmd>DBToggle<cr>", "DB Explorer" },
    j = { '<cmd>lua require("dbee").next()<cr>', "DB Next" },
    k = { '<cmd>lua require("dbee").prev()<cr>', "DB Prev" },
    s = { '<cmd>lua require("dbee").store("csv", "buffer", { extra_arg = 0 })<cr>', "DB to CSV" },
    S = { '<cmd>lua require("dbee").store("json", "buffer", { extra_arg = 0 })<cr>', "DB to JSON" },
    t = { '<cmd>lua require("dbee").store("table", "buffer", { extra_arg = 0 })<cr>', "DB to Table" },
  },
  f = {
    name = icons.ui.Telescope .. "Find",
    b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>",
      "Buffers",
    },
    c = { "<cmd>Telescope git_bcommits<cr>", "File Commits" },
    C = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
    e = { "<cmd>Oil<cr>", "Dir Editor" },
    f = { "<cmd>Telescope git_files find_command=fd,--hidden<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    a = { "<cmd>Telescope find_files find_command=fd,-I<cr>", "Find All Files" },
    G = { "<cmd>Telescope grep_string<cr>", "Find Under Cursor" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>Telescope commands<cr>", "Commands" },
    K = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    n = { "<cmd>enew<cr>", "New File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    p = { "<cmd>Telescope projects<cr>", "Panel" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    s = { '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', "Find with args" },
    S = { "<cmd>Telescope live_grep grep_open_files=true<cr>", "Find in Open Files" },
    L = { "<cmd>Telescope loclist<cr>", "Location List" },
    ['"'] = { "<cmd>Telescope registers<cr>", "Registers" },
    ["."] = { "<cmd>Telescope symbols<cr>", "Emojis" },
    [","] = { "<cmd>Nerdy<cr>", "Nerd Glyphs" },
  },
  g = {
    name = icons.git.Octoface .. "Git",
    a = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    A = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
    b = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Neogit commit<cr>", "Commit" },
    C = { "<cmd>GitCoAuthors<cr>", "Co Authors" },
    d = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    D = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    g = { "<cmd>LazygitToggle<cr>", "Lazygit" },
    h = { "<cmd>Octo<cr>", "Octo" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    n = { "<cmd>Neogit<cr>", "Neogit" },
    p = {
      '<cmd>silent execute "!(cd %:h && git pull --rebase --autostash &) > /dev/null" | lua require("notify")("Pulling Changes...")<cr>',
      "Pull Changes",
    },
    P = {
      '<cmd>silent execute "!(cd %:h && git push &) > /dev/null" | lua require("notify")("Pushing Changes...")<cr>',
      "Push Changes",
    },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Telescope git_status<cr>", "Changed files" },
    S = { "<cmd>Telescope git_stash<cr>", "Stashed Changes" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    y = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', "Copy Git URL" },
  },
  l = {
    name = icons.ui.Gear .. "LSP",
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
    D = { "<cmd>Lspsaga goto_definition<cr>", "Goto Definition" },
    f = { "<cmd>LspZeroFormat<cr>", "Format" },
    g = { "<cmd>Lspsaga finder<cr>", "Finder" },
    G = { "<cmd>Telescope lsp_references<cr>", "References" },
    h = { "<cmd>Lspsaga hover_doc<cr>", "Hover" },
    i = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    I = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    j = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
    k = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" },
    L = { "<cmd>LspInfo<cr>", "LSP Info" },
    o = { "<cmd>Lspsaga outline<cr>", "Outline" },
    p = { "<cmd>Telescope lsp_incoming_calls<cr>", "Incoming Calls" },
    P = { "<cmd>Telescope lsp_outgoing_calls<cr>", "Outgoing Calls" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    R = { "<cmd>Lspsaga project_replace<cr>", "Replace" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    t = { "<cmd>Lspsaga peek_type_definition<cr>", "Peek Type Definition" },
    T = { "<cmd>Lspsaga goto_type_definition<cr>", "Goto Type Definition" },
  },
  m = {
    name = icons.ui.Bookmark .. "Marks",
    a = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
    m = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
    ["k"] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
    ["j"] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
    ["s"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
  },
  n = {
    name = icons.ui.Note .. "Notes",
    c = { "<cmd>Telekasten show_calendar<cr>", "Calendar" },
    d = { "<cmd>vsplit || Telekasten goto_today<cr>", "Daily" },
    D = { "<cmd>Telekasten find_daily_notes<cr>", "Find Dailies" },
    f = { "<cmd>Telekasten find_notes<cr>", "Find Notes" },
    F = { "<cmd>Telekasten follow_link<cr>", "Follow Link" },
    g = { "<cmd>Telekasten search_notes<cr>", "Search String in Notes" },
    i = { "<cmd>Telekasten insert_link<cr>", "Insert Link" },
    J = { "<cmd>put =strftime('%F')<cr>", "Insert Date" },
    j = { "<cmd>put =strftime('%a %d %b %r')<cr>", "Insert Human Date" },
    K = { "<cmd>put =strftime('%F-%H-%M')<cr>", "Insert Time" },
    k = { "<cmd>put =strftime('%r')<cr>", "Insert Human Time" },
    t = { "<cmd>Telekasten show_tags<cr>", "Tags" },
    T = { "<cmd>Telescope live_grep cwd=$NOTES_DIR <cr>", "Search Notes" },
    n = { "<cmd>Telekasten new_note<cr>", "New Note" },
    N = { "<cmd>execute 'e '.strftime(\"%F\").'.md' <cr>", "New Note Here" },
    o = { "<cmd>Telekasten switch_vault<cr>", "Open Vault" },
    p = { "<cmd>Telekasten<cr>", "Telekasten" },
    s = {
      '<cmd>silent execute "!(cd $NOTES_DIR && cmtr -b &) > /dev/null" | lua require("notify")("Notes Commited")<cr>',
      "Commit Notes",
    },
    S = {
      '<cmd>silent execute "!(cd $NOTES_DIR && cmtr -s &) > /dev/null" | lua require("notify")("Syncing Changes...") <cr>',
      "Sync Notes",
    },
    w = { "<cmd>Telekasten goto_thisweek<cr>", "Weekly" },
    W = { "<cmd>Telekasten find_weekly_notes<cr>", "Find Weeklies" },
    x = { "<cmd>Telekasten toggle_todo<cr>", "Toggle Todo" },
    y = { "<cmd>Telekasten yank_notelink<cr>", "Copy Note Link" },
    z = {
      "<cmd>execute 'vsplit $NOTES_DIR/notes/drafts/'.strftime(\"%F-%H-%M\").'.md' <cr>",
      "New Zettelkasten",
    },
    Z = { "<cmd>execute 'e '.strftime(\"%F-%H-%M\").'.md' <cr>", "New Zettelkasten Here" },
  },
  r = {
    name = icons.diagnostics.Hint .. "Refactor",
    b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    e = { "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract Block" },
    f = { "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract Block To File" },
    i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
    r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor Commands" },
    S = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  },
  s = {
    name = icons.ui.Test .. "Tests",
    f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run Current File" },
    o = { "<cmd>Neotest output-panel<cr>", "Test Output" },
    r = { '<cmd>lua require("neotest").run.run()<cr>', "Run Current Test" },
    s = { "<cmd>Neotest summary<cr>", "Test Summary" },
  },
  t = {
    name = icons.ui.Terminal .. "Toggle",
    c = { "<cmd>ColorizerToggle<cr>", "Colorize" },
    d = { "<cmd>Dashboard<cr>", "Dashboard" },
    h = { "<cmd>Hardtime toggle<cr>", "Hardtime" },
    m = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview" },
    n = { "<cmd>NodeToggle<cr>", "Node" },
    p = { "<cmd>PythonToggle<cr>", "Python" },
    r = { "<cmd>RubyToggle<cr>", "Ruby" },
    s = { "<cmd>set spell!<cr>", "Spellcheck" },
    t = { "<cmd>ToggleTerm<cr>", "Floating Terminal" },
    u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
    v = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal Terminal" },
    V = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical Terminal" },
    w = { ":write | edit | TSBufEnable :qhighlight", "Highlight" },
    z = { "<cmd>ZenMode<cr>", "ZenMode" },
    Z = { "<cmd>Twilight<cr>", "Twilight" },
  },
  w = {
    name = icons.ui.Windows .. "Window",
    c = { "<cmd>tabclose<cr>", "Close Tab" },
    f = { "<cmd>tabfirst<cr>", "First Tab" },
    l = { "<cmd>tablast<cr>", "Last Tab" },
    o = { "<cmd>tabnext<cr>", "Next Tab" },
    O = { "<cmd>tabprevious<cr>", "Previous Tab" },
    q = { "<cmd>bw<cr>", "Close Current Buf" },
    s = { "<cmd>split<cr>", "Horizontal Split File" },
    t = { "<cmd>tabnew<cr>", "New Tab" },
    v = { "<cmd>vsplit<cr>", "Vertical Split File" },
    w = { "<cmd>w<cr>", "Write" },
    W = { "<cmd>lua require'utils'.sudo_write()<cr>", "Force Write" },
    x = { "<cmd>x<cr>", "Write and Quit" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
  s = { "<esc><cmd>'<,'>SnipRun<cr>", icons.ui.Play .. "Run Code" },
  g = {
    name = icons.git.Octoface .. "Git",
    y = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', "Copy Git URL" },
  },
  r = {
    name = icons.diagnostics.Hint .. "Refactor",
    r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor Commands" },
    e = { "<esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
    f = {
      "<esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
      "Extract Function To File",
    },
    v = { "<esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
    i = { "<esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
  },
  l = {
    name = icons.ui.Gear .. "LSP",
    a = "<cmd><C-U>Lspsaga range_code_action<CR>",
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register({ mode = { "o", "x" }, i = i, a = a })
