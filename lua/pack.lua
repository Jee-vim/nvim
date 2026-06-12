vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-vsnip",
  "https://github.com/hrsh7th/vim-vsnip",
  "https://github.com/hrsh7th/vim-vsnip-integ",
})

local map = vim.keymap.set

-- mini files ----
local MiniFiles = require("mini.files")
local string_match = string.match
MiniFiles.setup({
  mappings = {
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H",
  },
  content = {
    filter = function(fs_entry)
      if fs_entry.name == ".git" or fs_entry.name == "node_modules" then
        return false
      end

      if string_match(fs_entry.name, "^%.DS_Store$") then
        return false
      end

      return true
    end,
  },
})

map("n", "<leader>-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
map("n", "-", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

--- mini picker ---
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

map("n", "<leader>ff", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
map("n", "<leader>fo", function() MiniExtra.pickers.oldfiles() end, { desc = "Mini Old File Picker" })
map("n", "<leader>fg", function() MiniPick.builtin.grep_live({ pattern = vim.fn.expand("<cword>") }) end,
  { desc = "Grep word/Search word" })
map("n", "<leader>fh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })
map("n", "<leader>fk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })
map("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
map("n", "<leader>fc", function() MiniExtra.pickers.git_files({ scope = "modified" }) end,
  { desc = "Search changed files" })
map("n", "<leader>fX", function()
  local stdout = vim.fn.systemlist("git grep -l -F '<<<<<<< HEAD'")
  if vim.v.shell_error ~= 0 or #stdout == 0 then
    print("[INFO] No conflict markers found")
    return
  end

  MiniPick.start({
    source = {
      items = stdout,
      name = "Git Conflicts",
      choose = function(item) MiniPick.default_choose(item) end,
      preview = function(buf_id, item) MiniPick.default_preview(buf_id, item) end,
    },
  })
end, { desc = "Search conflict files" })

-- mini notify --
require("mini.notify").setup({
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

-- mini indentscope --
require("mini.indentscope").setup()

-- mini pairs --
require('mini.pairs').setup()

-- mini cmdline --
require("mini.cmdline").setup({
  autocorrect = { enable = false }
})

--- snippet ---
require('snippet').setup()

--- mini git ---
require("mini.git").setup()

map("n", "<leader>gs", "<cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Show Git data under cursor" })
map("n", "<leader>gn", "/^[<=>]\\{7\\}<CR>", { desc = "Next merge conflict" })
map("n", "<leader>gp", "?^[<=>]\\{7\\}<CR>", { desc = "Prev merge conflict" })
map("n", "<leader>go", function()
  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  local start_lnum = vim.fn.search("^<<<<<<<", "bnW")
  local end_lnum = vim.fn.search("^>>>>>>>", "nW")

  if start_lnum > 0 and end_lnum > 0 and cursor >= start_lnum and cursor <= end_lnum then
    local sep_lnum = 0
    local lines = vim.api.nvim_buf_get_lines(0, start_lnum - 1, end_lnum, false)
    for i, line in ipairs(lines) do
      if line:match("^=======$") then
        sep_lnum = start_lnum + i - 1
        break
      end
    end

    if sep_lnum > start_lnum and sep_lnum < end_lnum then
      vim.api.nvim_buf_set_lines(0, sep_lnum - 1, end_lnum, false, {})
      vim.api.nvim_buf_set_lines(0, start_lnum - 1, start_lnum, false, {})
    end
  else
    print("[WARN] Cursor is not inside a valid conflict block")
  end
end, { desc = "Choose Local (Our changes)" })

map("n", "<leader>gt", function()
  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  local start_lnum = vim.fn.search("^<<<<<<<", "bnW")
  local end_lnum = vim.fn.search("^>>>>>>>", "nW")

  if start_lnum > 0 and end_lnum > 0 and cursor >= start_lnum and cursor <= end_lnum then
    local sep_lnum = 0
    local lines = vim.api.nvim_buf_get_lines(0, start_lnum - 1, end_lnum, false)
    for i, line in ipairs(lines) do
      if line:match("^=======$") then
        sep_lnum = start_lnum + i - 1
        break
      end
    end

    if sep_lnum > start_lnum and sep_lnum < end_lnum then
      vim.api.nvim_buf_set_lines(0, end_lnum - 1, end_lnum, false, {})
      vim.api.nvim_buf_set_lines(0, start_lnum - 1, sep_lnum, false, {})
    end
  else
    print("[WARN] Cursor is not inside a valid conflict block")
  end
end, { desc = "Choose Remote (Their changes)" })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split", })
