return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      -- "nvim-treesitter/nvim-treesitter",
    },
    -- commit = "bca78924f47be69743eb66a44162b9389f506fb9",
    config = function()
      require("go").setup({
        -- lsp_cfg = true,
        -- lsp_cfg = {},
        -- verbose = true,
        lsp_inlay_hints = {
          enable = false,
          only_current_line = false,
        },
        lsp_codelens = false,
        diagnostic = {
          underline = false,
        },
        -- lsp_cfg = false,
        lsp_cfg = {
          flags = {
            debounce_text_changes = 0, -- fixes sticky diagnostic error messages
          },
          settings = {
            gopls = {
              analyses = {
                ST1003 = false,
                ST1000 = false,
                ST1020 = false,
                ST1021 = false,
                ST1022 = false,
              },
            },
          },
        },
      })
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
      return {
        -- lsp_keymaps = false,
        -- other options
      }
    end,
    -- keys = {
    --   { "<leader>tf", "<cmd>GoTestFunc<cr>", desc = "test current function" },
    --   { "<leader>tp", "<cmd>GoTestPkg<cr>", desc = "test current package" },
    -- },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
