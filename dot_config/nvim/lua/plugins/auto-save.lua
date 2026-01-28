return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChangedI" },
    opts = {
      debounce_delay = 400,
    },
  },
}
