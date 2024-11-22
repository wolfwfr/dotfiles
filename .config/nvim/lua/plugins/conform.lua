return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["go"] = { "goimports" },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
