return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local gitname = "-1"
    local function gitreponame()
      if gitname ~= "-1" then -- if already initialised
        return gitname
      end
      -- the following returns either the name of the git-repo or nothing at all
      local gitoutput = io.popen("git rev-parse --show-toplevel 2> /dev/null | xargs basename 2> /dev/null")
      readout = gitoutput:read("*a")
      readout = readout:sub(1, -2) -- string ends with '^@'; sub is safe with empty input
      gitname = readout
      gitoutput:close()
      return gitname
    end

    local opts = {
      sections = {
        lualine_b = { "branch", gitreponame },
      },
    }
    return opts
  end,
}
