vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })
map("n", "<leader>w", ":w<CR>", { desc = "Write", silent = true })
map("n", "<leader>q", ":q<CR>", { desc = "Quit", silent = true })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map("v", "<", "<gv", { desc = "Unident and keep selection" })
map("v", ">", ">gv", { desc = "Ident and keep selection" })

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

map("v", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
map("v", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

map("v", "n", "nzzzv", { desc = "Next search result cursor centered" })
map("v", "N", "Nzzzv", { desc = "Prev search result cursor centered" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor" })
map("n", "<leader>x", "<CMD>!chmod +x %<CR>", { desc = "Make file executable", silent = true })
map("n", "<leader>re", ":restart<CR>", { desc = "Restart" })

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
