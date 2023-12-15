local lsp = require("lsp-zero")

lsp.preset("recommended")

-- lsp servers
lsp.ensure_installed({
  "clangd",
  "lua_ls",
  "pylsp",
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.configure('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        ruff = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = {
          enabled = true,
          report_progress = true,
          live_mode = false
        },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        isort = { enabled = true },
      },
    },
  }
})

lsp.configure('clangd', {
  filetypes = { "c", "cpp", "cc" },
  flags = {
    debounce_text_changes = 500,
  },
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = '🆇',
    warn = '⚠️',
    hint = 'ℹ️',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)

require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
