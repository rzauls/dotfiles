-- LSP related configuration
return {
	{ -- LSP signature help
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "VeryLazy",
		opts = {
			autocmd = { enabled = true },
			---@type (fun(client_name:string, result:lsp.CodeAction|lsp.Command):boolean)|nil
			filter = function(client_name, result)
				if client_name == "gopls" and string.find(result.title, "Browse") then
					return false
				end
				return true
			end,
		},
	},
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			"j-hui/fidget.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("koili-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local map_mode = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")

					-- Jump to the implementation of the word under your cursor.
					map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

					-- Rename the variable under your cursor
					map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					-- map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
					map_mode({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client then
						if client.server_capabilities.documentHighlightProvider then
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.clear_references,
							})
						end
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
						end
					end
				end,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = {
					current_line = true,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- extend default capabilities with blink.cmp capabilities
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities) or {}

			-- List of servers that should be available
			local servers = {
				rust_analyzer = {},
				gopls = {},
				lua_ls = {
					-- cmd = {...}, -- Override command used to start the server
					-- filetypes { ...}, -- Override the default list of associated filetypes for the server
					-- capabilities = {}, -- Override fields in capabilities, can be used to disable certain LSP features.
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Help lua_ls find all neovim config files
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = {
								callSnippet = "Replace",
							},
							-- Hide noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			if not require("custom.util").is_mac then
				-- add glsl clang to serverrs
				servers.clangd = {
					capabilities = capabilities,
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
					},
				}

				servers.glsl_analyzer = {
					cmd = { "glsl_analyzer" },
					filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
					end,
					single_file_support = true,
					capabilities = {},
				}
			end

			-- Ensure the servers and tools above are installed
			require("mason").setup()

			-- Other tools that should be installed
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
				"staticcheck",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- Various helper tools to extend lsp diagnostics with custom stuff
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.staticcheck,
					null_ls.builtins.diagnostics.golangci_lint,
				},
			})
		end,
	},
}
