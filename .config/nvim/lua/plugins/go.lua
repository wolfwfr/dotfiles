return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = false,
          only_current_line = false,
        },
        diagnostic = {
          underline = false,
        },
        lsp_cfg = {
          flags = {
            debounce_text_changes = 0, -- fixes sticky diagnostic error messages
          },
          settings = {
            gopls = {
              analyses = {
                ST1003 = false,
              },
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>tf", "<cmd>GoTestFunc<cr>", desc = "test current function" },
      { "<leader>tp", "<cmd>GoTestPkg<cr>", desc = "test current package" },
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
