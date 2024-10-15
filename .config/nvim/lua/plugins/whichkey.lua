return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      { "<leader>n", group = "notes" },
      { "<leader>t", group = "test" },
      -- ["<leader>n"] = { name = "+notes" },
      -- ["<leader>t"] = { name = "+test" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
