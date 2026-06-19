vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() > 0 then
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)

    local files = {}
    local display_names = {}
    
    for _, file in ipairs(vim.v.oldfiles) do
      if vim.fn.filereadable(file) == 1 then
        table.insert(files, file)
        
        local short_name = vim.fn.fnamemodify(file, ":~")
        table.insert(display_names, short_name)
        
        if #files >= 10 then
          break
        end
      end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_names)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false

    -- Calculate screen center
    local ui = vim.api.nvim_list_uis()[1]
    local width = math.floor(ui.width * 0.6)
    local height = #files

    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((ui.width - width) / 2),
      row = math.floor((ui.height - height) / 2),
      style = "minimal",
    })

    vim.keymap.set("n", "<CR>", function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      local file = files[line] -- Uses the original full path to open it

      if file then
        vim.api.nvim_win_close(win, true)
        vim.cmd.edit(vim.fn.fnameescape(file))
      end
    end, { buffer = buf })
  end,
})
