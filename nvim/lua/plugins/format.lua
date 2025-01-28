return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "InsertLeave" },
    opts = {
      format_on_save = function()
        -- Disable with a global variable
        if not vim.g.autoformat then
          return
        end
        return { async = false, timeout_ms = 500, lsp_fallback = false }
      end,
      -- log_level = vim.log.levels.TRACE,
      formatters_by_ft = {
        html = { "prettier" },
        go = { "goimports", "gofmt" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier", "markdownlint-cli2" },
        python = { "ruff_format" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        toml = { "taplo" },
        typst = { "typstfmt" },
        yaml = { "yamlfmt" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      conform.formatters.shfmt = {
        prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
      }
      conform.formatters.stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
      }
      conform.formatters.yamlfmt = {
        prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
      }
      vim.g.autoformat = vim.g.autoformat
      vim.api.nvim_create_user_command("ToggleAutoformat", function()
        vim.api.nvim_notify("Toggling autoformat", vim.log.levels.INFO, { title = "conform.nvim", timeout = 2000 })
        vim.g.autoformat = vim.g.autoformat == false and true or false
      end, { desc = "Toggling autoformat" })
      vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
    end,
  },
}
