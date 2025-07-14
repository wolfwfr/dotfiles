return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    background = {
      dark = "wave",
      light = "lotus",
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        -- lazyGit selection row background defaults to palette.crystalBlue
        NormalFloat = { bg = "none" }, -- fg = e.g. terminal/lazygit primary text colours
        FloatBorder = { bg = "none", fg = colors.palette.winterYellow },
        FloatTitle = { bg = "none" },
        Pmenu = { bg = "none" }, -- bg = popup-menu background
        -- PmenuSel = { bg = "none", fg = colors.palette.samuraiRed },

        -- TelescopeTitle = { bg = "none" },
        -- TelescopeBorder = { bg = "none", fg = colors.palette.winterYellow },
        Normal = { fg = colors.palette.fujiWhite },

        -- was intended as temporary, but it's actually pretty sexy
        SnacksDashBoardTitle = { fg = "#27b427" },
        SnacksDashBoardHeader = { fg = "#27b427" },
        SnacksDashBoardFooter = { fg = "#27b427" },
        SnacksDashBoardDesc = { fg = "#1b671b" },
        SnacksDashBoardFile = { fg = "#1b671b" },
        SnacksDashBoardIcon = { fg = "#1b671b" },
        SnacksDashBoardSpecial = { fg = "#1b671b" },

        NeoTreeDirectoryName = { fg = "#8ba4b0" },
        NeoTreeDirectoryIcon = { fg = "#8ba4b0" },

        -- RenderMarkdownH1Bg = { bg = "#252535" },
        -- RenderMarkdownH2Bg = { bg = "#223249" },
        -- RenderMarkdownH3Bg = { bg = "#2D4F67" },
        -- RenderMarkdownH4Bg = { bg = "#2B3328" },
        -- RenderMarkdownH5Bg = { bg = "#49443C" },
        -- RenderMarkdownH6Bg = { bg = "#43242B" },
        -- RenderMarkdownH1Bg = { bg = "#" },
        -- RenderMarkdownH2Bg = { bg = "#" },
        -- RenderMarkdownH3Bg = { bg = "#" },
        -- RenderMarkdownH4Bg = { bg = "#" },
        -- RenderMarkdownH5Bg = { bg = "#" },
        -- RenderMarkdownH6Bg = { bg = "#" },
      }
    end,
    colors = {
      palette = {
        -- crystalBlue = "#393836", -- override crystalBlue for lazyGit UI improvement; crystalBlue is used as active line background
      },
      theme = {
        wave = {
          ui = {
            bg_dim = "#12120f",

            bg_m3 = "#0d0c0c",
            bg_m2 = "#12120f",
            bg_m1 = "#1D1C19",
            bg = "#181616",
            bg_p1 = "#282727",
            bg_p2 = "#393836",

            special = "#7a8382",
            whitespace = "#625e5a",
            nontext = "#625e5a",
          },
          syn = {
            fun = "#7E9CD8", -- I override crystalBlue for lazyGit UI improvement; fun defaults to crystalBlue; hard-code crystalBlue colour-code for compatibility
          },
        },
        dragon = {
          ui = {
            fg = "#DCD7BA", -- replace with wave theme colour
            fg_dim = "#C8C093", -- replace with wave theme colour
          },
        },
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
  },
}
