-- 端末の機能(OSC 52)で、nvimでコピーした内容をOS側クリップボードへ送る
vim.g.clipboard = 'osc52'
vim.opt.clipboard = 'unnamedplus'

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site/pack/lazy/start/lazy.nvim")

require("lazy").setup({
  { "neovim/nvim-lspconfig" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },

  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
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
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})

vim.lsp.enable({ "lua_ls", "ts_ls", "astro" })

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fr", telescope.lsp_references)
vim.keymap.set("n", "<leader>fd", telescope.lsp_definitions)

require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")

vim.keymap.set("n", "<leader>nt", "<cmd>Neotree toggle<cr>")
vim.keymap.set("n", "<leader>nf", "<cmd>Neotree focus<cr>")

