return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      api.config.mappings.default_on_attach(bufnr)

      local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
      vim.keymap.set("n", "v", api.node.open.vertical, opts)
      vim.keymap.set("n", "s", api.node.open.horizontal, opts)
      vim.keymap.set("n", "t", api.node.open.tab, opts)
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,
      view = {
        side = "right",
        width = 30,
      },
      update_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      actions = {
        open_file = {
          quit_on_open = false, -- ⬅️ keeps focus on the tree
          resize_window = true,
          window_picker = {
            enable = false,
          },
        },
      },
    })
  end,
}

