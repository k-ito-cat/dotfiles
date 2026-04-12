return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    event = "VimEnter",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          vim.cmd("Neotree show reveal")
        end,
      })
    end,
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
        },
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
      window = {
        width = 32,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["o"] = "open",
        },
      },
    },
    keys = {
      { "<leader>nt", "<cmd>Neotree toggle<cr>" },
      { "<leader>nf", "<cmd>Neotree focus<cr>" },
    },
  },
}
