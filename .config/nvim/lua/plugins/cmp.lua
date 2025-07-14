-- return {
--   "hrsh7th/nvim-cmp",
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     opts.window = {
--       completion = cmp.config.window.bordered(),
--       documentation = cmp.config.window.bordered(),
--     }
--     opts.mapping = cmp.mapping.preset.insert({
--       ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- use Tab for autocompletion
--       ["<C-j>"] = cmp.mapping.select_next_item(), -- use Ctrl-j to scroll down list
--       ["<C-k>"] = cmp.mapping.select_prev_item(), -- use Ctrl-k to scroll up list
--     })
--   end,
-- }

return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      -- patch for lazyvim due to API change of blink
      -- see https://github.com/LazyVim/LazyVim/pull/6183
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
      -- end of patch
    },
    sources = {
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
    completion = {
      menu = {
        winhighlight = "CursorLine:BlinkCmpSignatureHelpActiveParameter",
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },
  },
}
