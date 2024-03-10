return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    opts.mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- use Tab for autocompletion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- use Ctrl-j to scroll down list
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- use Ctrl-k to scroll up list
    })
  end,
}
