return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",   -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",     -- Buffer completions
    "hrsh7th/cmp-path",       -- Path completions
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
    "L3MON4D3/LuaSnip",       -- Snippet engine
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })

    -- Optional: integrate with nvim-autopairs if desired
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

