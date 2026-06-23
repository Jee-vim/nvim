function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlighting"})
map("n", "<leader>w", ":w<CR>", { desc = "Write" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>re", ":restart<CR>", { desc = "Restart" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

map("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

map("n", "n", "nzz", { desc = "Next search result cursor centered" })
map("n", "N", "Nzz", { desc = "Prev search result cursor centered" })
map("n", "G", "Gzz", { desc = "Go to bottom and center" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], {
  desc = "Replace word under cursor"
})
map("n", "<leader>S", function()
  local cwd = vim.fn.expand("<cword>")
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(
      ":vimgrep /" .. cwd .. "/ `git ls-files`<CR>:copen<CR>:cfdo %s/" .. cwd .. "/",
      true, false, true
    ),
    "n", false
  )
end, { desc = "Replace word under cursor in all files" })

map("n", "<leader>bd", "<CMD>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>ba", "<CMD>%bd|e#<CR>", { desc = "Close all buffers except current" })
map("n", "<leader>bb", "<CMD>b#<CR>", { desc = "Previous buffer" })

map("n", "<leader>hy", "vatzf<CR>", { desc = "Hide Tag (HTML/JSX)" })
map("n", "<leader>hn", "vaBzf", { desc = "Hide Block (Braces)" })
map("n", "<leader>ho", "zo", { desc = "Show / Open Fold" })

map("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle Undotree" })
