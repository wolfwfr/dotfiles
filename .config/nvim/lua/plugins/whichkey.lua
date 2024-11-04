return {
  "folke/which-key.nvim",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>n", group = "notes" },
      { "<leader>t", group = "test" },
    })
  end,
}
