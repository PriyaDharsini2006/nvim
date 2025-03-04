return {
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" }, -- Default mapping
      { "lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit", mode = "n" }, -- Custom mapping for `lg`
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true, -- Enable Git blame inline
        current_line_blame_opts = {
          delay = 200,
          virt_text = true,
          virt_text_pos = "eol", -- Show at end of line
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/trouble.nvim", -- For enhanced diagnostics
      "ErichDonGubler/lsp_lines.nvim",
    },
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false, -- Hide default virtual text
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- Toggle error lens with a keybind
      vim.keymap.set("n", "<Leader>el", function()
        local current = vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = not current })
      end, { desc = "Toggle Error Lens" })
    end,
  },
}
