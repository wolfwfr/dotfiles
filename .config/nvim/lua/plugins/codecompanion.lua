return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  opts = {
    ignore_warnings = true,
    display = {
      action_palette = {
        provider = "default",
      },
      chat = {
        -- shows model in use, but also blocks live model change
        -- show_settings = true,
      },
    },
    interactions = {
      chat = {
        adapter = "openrouter",
      },
      inline = {
        adapter = {
          name = "openrouter",
          model = "anthropic/claude-sonnet-4",
        },
      },
      cmd = {
        adapter = "openrouter",
      },
    },
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "cmd:pass show innius.openrouter.ai/api_key",
            },
            schema = {
              model = {
                default = "anthropic/claude-sonnet-4.5",
                choices = {
                  -- to change adapter, open chat & input 'ga' in Normal mode
                  ["openai/o3-mini-2025-01-31"] = { opts = { can_reason = true } },
                  "anthropic/claude-3.5-sonnet",
                  "anthropic/claude-3.7-sonnet",
                  "anthropic/claude-3.7-sonnet-thought",
                  "anthropic/claude-sonnet-4",
                  "anthropic/claude-sonnet-4.5",
                },
              },
            },
          })
        end,
      },
    },
    prompt_library = {
      ["commit range summary"] = {
        interaction = "chat",
        description = "create a description of the changes contained within a range of commits",
        prompts = {
          {
            role = "user",
            -- TODO: add commit buffers & diffs to history
            content = "You are an experienced software engineer writing up a concise pull-request summary of the changes applied to the code.",
          },
        },
      },
      ["desc_func"] = {
        interaction = "inline",
        description = "create a function description",
        opts = {
          placement = "replace", -- "new""|"replace"|"add"|"before"|"chat"
        },
        prompts = {
          {
            role = "user",
            content = [[
            Create a description for the given function and position it above the function.
            Start with 'The <function>()', replacing <function> with the function-name.
            ]],
          },
        },
      },
      ["Code workflow"] = {
        interaction = "workflow",
        opts = {
          adapter = {
            name = "openrouter",
            model = "anthropic/claude-3.5-sonnet",
          },
        },
      },
    },
  },
  keys = {
    -- This function triggers plugin load *and* calls select_model immediately upon press
    {
      "<leader>Cs",
      select_model,
      desc = "Select model",
      noremap = true,
      silent = true,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  init = function()
    require("extras.companion-fidget"):init()
  end,
}
