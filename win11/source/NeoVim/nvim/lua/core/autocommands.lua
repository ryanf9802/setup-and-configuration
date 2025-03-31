vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p:h")
    vim.cmd("lcd " .. path)
  end,
})

if vim.fn.argc() == 1 then
  local stat = vim.loop.fs_stat(vim.fn.argv(0))
  if stat and stat.type == "directory" then
    vim.cmd.cd(vim.fn.argv(0))
    vim.cmd.enew()
    vim.cmd("NvimTreeToggle")
  end
end
