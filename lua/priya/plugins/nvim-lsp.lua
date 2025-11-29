return {
  -- LSP Configuration
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "lua_ls",
        "jsonls",
        "lemminx",
        "marksman",
        "quick_lint_js",
        "pylsp",
        "gopls", -- ✅ Added Go LSP
        -- "tsserver",
        -- "yamlls",
      },
    })

    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- You can define keymaps or on_attach logic here
    end

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end,

      -- Python LSP
      ["pylsp"] = function()
        lspconfig.pylsp.setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
          settings = {
            pylsp = {
              plugins = {
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pylsp_mypy = { enabled = true },
                jedi_completion = { fuzzy = true },
                pyls_isort = { enabled = true },
              },
            },
          },
          flags = { debounce_text_changes = 200 },
        })
      end,

      -- ✅ Go LSP setup
      ["gopls"] = function()
        lspconfig.gopls.setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
            },
          },
        })
      end,
    })

    -- Lua LSP config
    lspconfig.lua_ls.setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            virtual_text = true,
          },
        },
      },
    })

    -- Rounded border on hover/signature
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
