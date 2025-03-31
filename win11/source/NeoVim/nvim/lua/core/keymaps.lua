vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file or selection" })

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fb", function() require("telescope").extensions.file_browser.file_browser() end,
  { desc = "File browser" })
vim.keymap.set("n", "<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end,
  { desc = "Find in current file" })
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Find files in Git repo
vim.keymap.set("n", "<leader>fs", function()
  require("telescope.builtin").git_files()
end, { desc = "Find Git-tracked files" })

vim.keymap.set("n", "<leader>fg", function()
  local is_git = vim.fn.isdirectory(".git") == 1
  local opts = {}

  if is_git then
    opts.search_dirs = vim.fn.systemlist("git ls-files")
  end

  require("telescope.builtin").live_grep(opts)
end, { desc = "Live grep (Git files if in repo)" })

-- Smart fallback if not in Git repo
vim.keymap.set("n", "<leader>p", function()
  local ok = pcall(require("telescope.builtin").git_files)
  if not ok then
    require("telescope.builtin").find_files()
  end
end, { desc = "Project files (smart)" })

