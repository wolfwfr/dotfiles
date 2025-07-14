return {
  {
    -- enabled = false,
    dir = "/home/wolf/Projects/src/github.com/wolfwfr/vimatrix.nvim",
    -- dir = "/home/wolf/Projects/src/github.com/wolfwfr/refactor",
    -- "wolfwfr/vimatrix.nvim",
    -- enabled = false,
    opts = {
      droplet = {
        max_size_offset = 5,
        timings = {
          max_fps = 20,
          fps_variance = 2,
          glitch_fps_divider = 8,
          max_timeout = 200,
          local_glitch_frame_sharing = false,
          global_glitch_frame_sharing = true,
        },
        random = {
          body_to_tail = 50,
          head_to_glitch = 5,
          head_to_tail = 50,
          kill_head = 100,
          new_head = 30,
        },
      },
      -- keys = {
      --   cancellation = { "q" },
      -- },
      -- keys = {
      --   cancellation = { "<Esc>" },
      -- },
      colourscheme = "matrix",
      auto_activation = {
        screensaver = {
          timeout = 180,
          -- setup_deferral = 2,
          -- block_on_term = false,
          -- block_on_cmd_line = true,
        },
        on_filetype = { "snacks_dashboard" },
      },
      logging = {
        print_errors = true,
        log_level = vim.log.levels.DEBUG,
      },
      window = {
        general = {
          background = "#000000",
          -- background = "",
          blend = 0,
        },
        by_filetype = {
          snacks_dashboard = {
            -- column_density_divider = 2,
            border = "none",
            background = "",
            blend = 100,
            ignore_cells = function(_, ln, cl)
              -- return (ln > 23 and ln < 32) and (cl > 67 and cl < 215)
              --   or (ln > 30 and ln < 55) and (cl > 109 and cl < 175)
              local title_width = 113
              local options_width = 70

              local title_height = 11
              local total_height = 34

              local title_cl_start = math.floor((vim.go.columns - title_width) / 2)
              local title_cl_end = title_cl_start + title_width + 1

              local options_cl_start = math.floor((vim.go.columns - options_width) / 2)
              local options_cl_end = options_cl_start + options_width + 1

              local total_ln_start = math.floor((vim.go.lines - total_height) / 2)
              local total_ln_end = total_ln_start + total_height + 1

              local title_ln_start = total_ln_start
              local title_ln_end = title_ln_start + title_height + 1

              return (ln > title_ln_start and ln < title_ln_end) and (cl > title_cl_start - 3 and cl < title_cl_end + 3)
                or (ln > total_ln_start and ln < total_ln_end) and (cl > options_cl_start - 1 and cl < options_cl_end + 1)
                or (ln == vim.go.lines)
              -- return (ln > 23 and ln < 32) and (cl > 84 and cl < 198)
              --   or (ln > 30 and ln < 58) and (cl > 105 and cl < 179)
              --   or (ln == vim.go.lines)
            end,
          },
        },
      },
      alphabet = {
        -- built_in = { "armenian", "symbols", "decimals" },
        -- built_in = {},
        -- custom = { "00", "11", "01", "10" },
        -- built_in = { "russian" },
      },
    },
  },
}
