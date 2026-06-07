vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
  "https://github.com/tpope/vim-fugitive",
})

local map = vim.keymap.set

-- mini files ----
local MiniFiles = require("mini.files")
MiniFiles.setup({
  mappings = {
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H",
  },
})

map("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
map("n", "<leader>-", function()
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
map("n", "<leader>fg", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,
  { desc = "Grep word/Search word" })
map("n", "<leader>fh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })
map("n", "<leader>fk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })
map("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
map("n", "<leader>fc", function() MiniExtra.pickers.git_files({ scope = "modified" }) end,
  { desc = "Search changed files" })
map("n", "<leader>fX", function() MiniExtra.pickers.git_files({ scope = "unmerged" }) end,
  { desc = "Search conflict files" })

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

--- mini completions ---
require("mini.completion").setup({
  lsp_completion = {
    auto_setup = true,
  }
})

--- mini snippets ---
local gen_loader = require('mini.snippets').gen_loader
local snippets_dir = vim.fn.expand('~/.config/nvim/snippets')

require('mini.snippets').setup({
  mappings = {
    expand = '<Tab>',
  },
  snippets = {
    gen_loader.from_lang({ path = snippets_dir }),
    gen_loader.from_file(snippets_dir .. '/global.json'),
  },
})

--- mini git ---
require("mini.git").setup()

map("n", "<leader>gs", "<cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Show Git data under cursor" })
map("n", "<leader>gn", "/^[<=>]\\{7\\}<CR>", { desc = "Next merge conflict" })
map("n", "<leader>gp", "?^[<=>]\\{7\\}<CR>", { desc = "Prev merge conflict" })
map("n", "<leader>go", "<cmd>%diffget LOCAL<CR>", { desc = "Choose Local (Our changes)" })
map("n", "<leader>gi", "<cmd>%diffget REMOTE<CR>", { desc = "Choose Remote (Incoming changes)" })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split", })
