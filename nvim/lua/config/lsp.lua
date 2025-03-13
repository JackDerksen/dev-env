-- LSP configuration module
local M = {}

-- Setup LSP keymaps for a buffer
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
  end

  -- Keymaps
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "gr", vim.lsp.buf.references, "Goto References")
  map("n", "gt", vim.lsp.buf.type_definition, "Type Definition")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List Workspace Folders")
  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format")

  -- Set autocommands conditional on server capabilities
  if client.server_capabilities.documentHighlightProvider then
    local highlight_group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = highlight_group,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = highlight_group,
    })
  end
end

-- Setup LSP servers
function M.setup()
  -- Configure diagnostics
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
  })

  -- Set diagnostic signs
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = "󰍉 ",
    Info = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  -- Setup LSP handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- Get cmp capabilities if available
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- Create a special capabilities object for clangd
  local clangd_capabilities = vim.deepcopy(capabilities)
  clangd_capabilities.offsetEncoding = { "utf-16" }

  -- LSP server configurations
  local lspconfig = require("lspconfig")

  -- Lua LSP
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })

  -- C/C++ LSP
  lspconfig.clangd.setup({
    capabilities = clangd_capabilities,
    on_attach = M.on_attach,
    cmd = {
      "clangd",
      "--header-insertion=never",
      "--clang-tidy",
    },
  })

  -- Rust LSP
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  })

  -- Astro LSP
  lspconfig.astro.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  -- Python LSP
  lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            maxLineLength = 100,
          },
        },
      },
    },
  })
end

return M
