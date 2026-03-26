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
