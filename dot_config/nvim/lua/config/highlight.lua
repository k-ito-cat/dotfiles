local function link(group, target)
  vim.api.nvim_set_hl(0, group, { link = target })
end

local function apply()
  link("@variable", "Identifier")
  link("@variable.builtin", "Special")
  link("@variable.parameter", "Identifier")
  link("@variable.member", "Identifier")

  link("@constant", "Constant")
  link("@constant.builtin", "Special")

  link("@function", "Function")
  link("@function.call", "Function")
  link("@method", "Function")
  link("@method.call", "Function")

  link("@property", "Identifier")
  link("@field", "Identifier")

  link("@type", "Type")
  link("@type.builtin", "Type")

  link("@namespace", "Identifier")

  link("@lsp.type.variable", "@variable")
  link("@lsp.type.parameter", "@variable.parameter")
  link("@lsp.type.property", "@property")
  link("@lsp.type.method", "@method")
  link("@lsp.type.function", "@function")
  link("@lsp.type.type", "@type")
  link("@lsp.type.class", "@type")
  link("@lsp.type.interface", "@type")
  link("@lsp.type.enum", "@type")
  link("@lsp.type.struct", "@type")
  link("@lsp.type.enumMember", "@constant")
  link("@lsp.type.namespace", "@namespace")
end

apply()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("HighlightOverrides", { clear = true }),
  callback = apply,
})
