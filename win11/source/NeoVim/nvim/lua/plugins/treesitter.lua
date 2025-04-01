return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "lua",
        "python",
        "markdown",
        "markdown_inline",
        "json",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "html",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" }, -- Needed for full markdown highlighting
      },
      indent = {
        enable = true,
      },
    })
  end,
}

