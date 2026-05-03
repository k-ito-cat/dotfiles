local servers = { "lua_ls", "ts_ls", "astro", "jsonls", "svelte", "tailwindcss" }

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  local capabilities = cmp_nvim_lsp.default_capabilities()
  for _, server in ipairs(servers) do
    vim.lsp.config(server, { capabilities = capabilities })
  end
end

vim.lsp.enable(servers)
