return {
  -- Mason - LSP installer
  {
    "williamboman/mason.nvim",
    priority = 100,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- mason-lspconfig - Bridge between Mason and LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    priority = 90,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "ts_ls",
          "pyright",
          "rust_analyzer",
          "gopls",
          "clangd",
          "jsonls",
          "yamlls",
          "bashls",
          "dockerls",
          "tailwindcss",
          "emmet_ls",
          "yuck"
        },
        automatic_installation = true,
      })
    end,
  },

  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
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
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "path",     priority = 500 },
        }, {
          { name = "buffer", keyword_length = 3, priority = 250 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Command line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Search completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
  
  -- LSP CONFIGURATION (NEW vim.lsp.config API for Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      -- Setup neodev BEFORE LSP config
      require("neodev").setup({})

      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- DIAGNOSTIC CONFIGURATION
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
          source = "if_many",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- HANDLERS - Better UI
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- CAPABILITIES
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- ON_ATTACH - Keymaps and features
      local on_attach = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
          vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
          vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
          vim.tbl_extend("force", opts, { desc = "Signature help" }))
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help,
          vim.tbl_extend("force", opts, { desc = "Signature help" }))

        -- Workspace
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
          vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
          vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

        -- Code actions
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))

        -- Formatting
        vim.keymap.set("n", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

        vim.keymap.set("v", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format selection" }))

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
          vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float,
          vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist,
          vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))

        -- Inlay hints (if supported)
        if client.server_capabilities.inlayHintProvider then
          vim.keymap.set("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
        end

        -- Document highlight
        if client.server_capabilities.documentHighlightProvider then
          local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })
        end

        vim.notify("✓ LSP attached: " .. client.name, vim.log.levels.INFO)
      end

      -- Setup LspAttach autocommand
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = on_attach,
      })

      -- ========================================================================
      -- SERVER CONFIGURATIONS (NEW vim.lsp.config API)
      -- ========================================================================

      -- Lua
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".git" },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = { callSnippet = "Replace" },
            hint = { enable = true },
          },
        },
      })

      -- HTML
      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
      })

      -- CSS
      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Python
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            cargo = { allFeatures = true },
            procMacro = { enable = true },
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = "always" },
              renderColons = true,
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
          },
        },
      })

      -- Go
      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.mod", "go.work", ".git" },
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- C/C++
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
        capabilities = capabilities,
      })

      -- JSON
      vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        capabilities = capabilities,
      })

      -- YAML
      vim.lsp.config("yamlls", {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_markers = { ".git" },
        capabilities = capabilities,
      })

      -- Bash
      vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
        capabilities = capabilities,
      })

      -- Docker
      vim.lsp.config("dockerls", {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { ".git" },
        capabilities = capabilities,
      })

      -- Tailwind CSS
      vim.lsp.config("tailwindcss", {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "tailwind.config.js", "tailwind.config.ts", ".git" },
        capabilities = capabilities,
      })

      -- Emmet
      vim.lsp.config("emmet_ls", {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { ".git" },
        capabilities = capabilities,
      })

      -- ========================================================================
      -- AUTO-ENABLE LSP FOR FILETYPES
      -- ========================================================================
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua", "html", "css", "scss", "less",
          "javascript", "typescript", "javascriptreact", "typescriptreact",
          "python", "rust", "go", "gomod", "gowork",
          "c", "cpp", "objc", "objcpp",
          "json", "jsonc", "yaml", "yml",
          "sh", "bash", "dockerfile",
        },
        callback = function()
          local ft = vim.bo.filetype
          local server_map = {
            lua = "lua_ls",
            html = "html",
            css = "cssls",
            scss = "cssls",
            less = "cssls",
            javascript = "ts_ls",
            javascriptreact = "ts_ls",
            typescript = "ts_ls",
            typescriptreact = "ts_ls",
            python = "pyright",
            rust = "rust_analyzer",
            go = "gopls",
            gomod = "gopls",
            gowork = "gopls",
            c = "clangd",
            cpp = "clangd",
            objc = "clangd",
            objcpp = "clangd",
            json = "jsonls",
            jsonc = "jsonls",
            yaml = "yamlls",
            yml = "yamlls",
            sh = "bashls",
            bash = "bashls",
            dockerfile = "dockerls",
          }

          local server = server_map[ft]
          if server then
            vim.lsp.enable(server)
          end

          -- Enable tailwind for web filetypes
          if vim.tbl_contains({ "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" }, ft) then
            vim.lsp.enable("tailwindcss")
            vim.lsp.enable("emmet_ls")
          end
        end,
      })
    end,
  },

  -- ============================================================================
  -- NEODEV - Neovim Lua API completion
  -- ============================================================================
  {
    "folke/neodev.nvim",
    ft = "lua",
  },

  -- ============================================================================
  -- LSPKIND - VS Code-like pictograms
  -- ============================================================================
  {
    "onsails/lspkind.nvim",
  },

  -- ============================================================================
  -- FIDGET - LSP Progress UI
  -- ============================================================================
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
          border = "rounded",
        },
      },
    },
  },

  -- ============================================================================
  -- SNIPPET ENGINE
  -- ============================================================================
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- ============================================================================
  -- AUTOPAIRS - Auto close with LSP integration
  -- ============================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })

      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
