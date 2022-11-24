local actions = require("telescope.actions")

require('telescope').setup {
  defaults = {
    preview = false,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
}
