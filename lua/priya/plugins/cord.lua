return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    editor = {
      client = "neovim",
      tooltip = "Neovim",
    },
    display = {
      theme = "catppuccin",
    },
    text = {
      workspace = function(opts)
        return string.format("%s", "Commiting Crimes")
      end,
    },
  },
}
