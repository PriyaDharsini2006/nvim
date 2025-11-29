return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = function(bufnr)
      local ignore_filetypes = { "env" }
      local ft = vim.bo[bufnr].filetype
      if vim.tbl_contains(ignore_filetypes, ft) then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,

    formatters = {
      prettier = {
        options = {
          tabWidth = 2,
          singleQuote = true,
          bracketSpacing = false,
          parser = "flow",
          trailingComma = "es5",
        },
      },
    },

    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      toml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "isort" },
      cpp = { "clang-format" },
      go = { "gofumpt" },
      rust = { "rustfmt" },
      env = {},
    },
  },
}
