return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      settings = {
        ["*"] = {
          keys = {
            {
              "<c-k>",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = "n",
              desc = "Signature Help",
              has = "signatureHelp",
            },
          },
        },
      },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
