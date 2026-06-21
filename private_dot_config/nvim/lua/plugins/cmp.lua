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
      -- preset = "super-tab",
      preset = "none", -- below is adapted from preset 'super-tab'
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      -- ["<C-k>"] = { "fallback" },
    },
    sources = {
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        snippets = {
          score_offset = -10,
        },
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
