if true then
  return {}
end
---- autocmds.lua

---- keymaps.lua

-- vim.keymap.set("n", "{", "{zz", { silent = true })
-- vim.keymap.set("n", "}", "}zz", { silent = true })

---- lazy.lua

-- require("lazy").setup({
--   spec = {
--     --{ import = "lazyvim.plugins.extras.test.core" },
--     --{ import = "lazyvim.plugins.extras.lang.go" },
--     -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
--   },
--   performance = {
--     rtp = {
--       -- disable some rtp plugins
--       disabled_plugins = {
--         -- "matchit",
--         -- "matchparen",
--         -- "netrwPlugin",
--       },
--     },
--   },
-- })

---- options.lua

-- next section aims to include source into any diagnostics message, but likely isn't required. Delete after some time if not useful.
-- same can probably be achieved with:
--vim.diagnostic.config({
--     float = {
--         source = "always",
--     },
-- })
--
-- section in question:
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
--   local config = { -- your diagnostic display configuration
--     underline = true,
--     virtual_text = {
--       prefix = "●",
--       spacing = 4,
--     },
--     signs = true,
--     update_in_insert = true,
--   }
--   local uri = params.uri
--   if not uri then
--     return
--   end
--   local bufnr = vim.uri_to_bufnr(uri)
--
--   if not bufnr then
--     return
--   end
--
--   local diagnostics = params.diagnostics
--
--   for _, diagnostic in ipairs(diagnostics) do
--     if diagnostic.source then
--       diagnostic.message = string.format("%s: %s", diagnostic.source, diagnostic.message)
--     end
--   end
--
--   vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)
--   vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
-- end
