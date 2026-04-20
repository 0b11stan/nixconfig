require('snacks').setup({
  image = { enable = true },
  explorer = { enable = true },
  indent = { enable = true },
  terminal = {
    enable = true
  },
  picker = {
    sources = {
      explorer = {
        win = {
          input = {
            keys = {
              ["k"] = "list_down",
              ["l"] = "list_up",
            }
          },
          list = {
            keys = {
              ["k"] = "list_down",
              ["l"] = "list_up",
            }
          }
        }
      }
    }
  }
})

vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#808080", italic = true })
