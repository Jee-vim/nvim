local M = {}

function M.setup(opts)
  opts = opts or {}
  local snippet_dir = opts.snippet_dir or vim.fn.stdpath("config") .. "/snippets"

  vim.g.vsnip_snippet_dir = snippet_dir
  vim.g.vsnip_filetypes = {
    typescriptreact = {"html",  "javascript", "typescript" },
    vue = { "html", "javascript", "css" },
  }

  local cmp = require('cmp')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    completion = {
      autocomplete = { cmp.TriggerEvent.TextChanged },
    },
    window = {
      completion = cmp.config.window.bordered({ border = 'single' }),
      documentation = cmp.config.window.bordered({ border = 'single' }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "vsnip" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size <= 1024 * 1024 then
                bufs[buf] = true
              end
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
    }),
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<A-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#available"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<A-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-jump-next)", "")
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
  })
end

return M
