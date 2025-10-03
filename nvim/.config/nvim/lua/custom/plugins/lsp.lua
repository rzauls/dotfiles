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

					-- Most keymaps are in snacks.lua since they produce multiple results and require a picker from snacks.picker
					map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					-- map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
					map_mode({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					map("K", function()
						vim.lsp.buf.hover({
							border = "rounded",
						})
					end, "Hover Documentation")

					-- Toggle inline diagnostics
					map("L", function()
						local current_value = vim.diagnostic.config().virtual_lines
						if current_value == false then
							vim.diagnostic.config({
								virtual_lines = { current_line = true },
								virtual_text = false,
							})
						else
							vim.diagnostic.config({
								virtual_lines = false,
								virtual_text = true,
							})
						end
					end, "Toggle inline virtual_line diagnostics Documentation")

					-- Highlight reference in document on hover
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

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- extend default capabilities with blink.cmp capabilities
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities, true) or {}

			-- List of servers that should be available
			local servers = {
				rust_analyzer = {},
				gopls = {},
				lua_ls = {
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
						},
					},
				},
				intelephense = {
					settings = {
						intelephense = {
							codeLens = {
								enable = true,
							},
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

			---@diagnostic disable-next-line: missing-fields
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
