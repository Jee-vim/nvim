local map = vim.keymap.set
map('n', '<leader>ld', vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Local buffer" })
map('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename Symbole" })
map('n', "<leader>lj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", {
    root_markers = { ".git", "package.json", "tsconfig.json" },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            },
        },
    },
})

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = false,
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})
vim.lsp.config("astro", {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" }
})

vim.lsp.config("css", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore", -- hide unknownAtRules warning in tailwind css
            },
        },
        scss = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            }
        },
        less = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            }
        },
    },
})

vim.lsp.config("nixd", {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
        ["nixd"] = {
            formatting = {
                command = { "alejandra" },
            },
        },
    },
})

vim.lsp.config("zls", {
    cmd = { "zls" },
    filetypes = { "zig" },
    root_markers = { "build.zig", ".git" },
})

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

vim.lsp.enable({
    "lua_ls",
    "astro",
    "css",
    "nixd",
    "ts_ls",
    "zls",
})
