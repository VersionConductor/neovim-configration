return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = "night",
        transparent = false,
        day_brightness = 0.5,
        styles = {
          functions = {}
        },
        on_colors = function(colors)
          colors.hint = colors.orange
          colors.error = "#ff0000"
        end
      })
    end
  }
}
