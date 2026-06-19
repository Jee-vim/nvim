vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() > 0 then
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)

    local files = {}
    for _, file in ipairs(vim.v.oldfiles) do
      if vim.fn.filereadable(file) == 1 then
        table.insert(files, file)
        if #files >= 10 then
          break
        end
      end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false

    vim.api.nvim_set_current_buf(buf)

    vim.keymap.set("n", "<CR>", function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      local file = files[line]

      if file then
        vim.cmd.edit(vim.fn.fnameescape(file))
      end
    end, { buffer = buf })
  end,
})
