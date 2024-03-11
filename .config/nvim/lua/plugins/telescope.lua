return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = {
        border = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-p>"] = actions.preview_scrolling_right,
          },
        },
      }
      opts.pickers = {
        find_files = {
          hidden = true,
        },
      }
    end,

    -- opts = {
    --   defaults = {
    --     border = true,
    --     -- mappings = {
    --     --   i = {
    --     --     ["<C-j>"] = "next_item",
    --     --     ["<C-k>"] = "previous_item",
    --     --     -- ["<C-p>"] = "",
    --     --   },
    --     -- },
    --   },
    --   pickers = {
    --     find_files = {
    --       hidden = true,
    --     },
    --   },
    -- },
  },
}
