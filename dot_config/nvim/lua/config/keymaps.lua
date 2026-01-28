vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
