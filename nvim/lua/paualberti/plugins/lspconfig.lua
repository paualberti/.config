-- LSP Plugins
return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"ibhagwan/fzf-lua",
		},
		opts = {
			servers = {
				clangd = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					vim.keymap.set(M.n, "gd", "<CMD>FzfLua lsp_definitions<CR>", { desc = "Definition" })
					vim.keymap.set(M.n, "gD", "<CMD>FzfLua lsp_declarations<CR>", { desc = "Declaration" })
					vim.keymap.set(M.n, "gR", "<CMD>FzfLua lsp_references<CR>", { desc = "References" })
					vim.keymap.set(M.n, "gI", "<CMD>FzfLua lsp_implementation<CR>", { desc = "Implementation" })

					vim.keymap.set(M.n, Leader .. "ca", "<CMD>FzfLua lsp_code_actions<CR>", { desc = "Action" })
					vim.keymap.set(M.n, Leader .. "cd", "<CMD>FzfLua lsp_typedefs<CR>", { desc = "Type Definition" })
					vim.keymap.set(M.n, Leader .. "cr", vim.lsp.buf.rename, { desc = "Rename" })
					vim.keymap.set(
						M.n,
						Leader .. "cs",
						"<CMD>FzfLua lsp_document_symbols<CR>",
						{ desc = "Document Symbols" }
					)
					vim.keymap.set(
						M.n,
						Leader .. "cw",
						"<CMD>FzfLua lsp_workspace_symbols<CR>",
						{ desc = "Workspace Symbols" }
					)
				end,
			})
			vim.keymap.set(M.n, Leader .. "cl", "<CMD>Lazy<CR>", { desc = "Lazy" })
			vim.keymap.set(M.n, Leader .. "cm", "<CMD>Mason<CR>", { desc = "Mason" })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local ensure_installed = vim.tbl_keys(opts.servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"clang-format",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			for server, config in pairs(opts.servers) do
				require'lspconfig'[server].setup(config)
			end
		end,
	},
}
