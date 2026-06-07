# nvim-config

Personal Neovim config — rewritten for speed and simplicity.
Zero external plugin manager. Built on Neovim >=0.11's native `vim.pack`.

## Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── options.lua
│   ├── keymaps.lua
│   ├── commands.lua
│   ├── pack.lua
│   ├── treesitter.lua
│   └── lsp.lua
├── snippets/
└── nvim-pack-lock.json
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | Colorscheme |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | Modular utilities (see below) |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |

### mini.nvim Modules Used

- **mini.files** — File explorer (`-` to toggle)
- **mini.pick** — Fuzzy finder (files, grep, help, diagnostics, git files)
- **mini.notify** — Notification system
- **mini.indentscope** — Indent guides
- **mini.pairs** — Auto-pair brackets/quotes
- **mini.cmdline** — Enhanced command-line
- **mini.completion** — LSP-powered completion
- **mini.snippets** — Snippet engine (`<Tab>` to expand)
- **mini.git** — Git porcelain (`<leader>gs`/`<leader>gd`)

## Commands

| Command | Description |
|---------|-------------|
| `:PackAdd user/repo` | Add plugin (Non Permanent) |
| `:PackDel plugin` | Remove plugin (0.13+) |
| `:PackUpdate [plugin]` | Update all plugins or specific ones |
