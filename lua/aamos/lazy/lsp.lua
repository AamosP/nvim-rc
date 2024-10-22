return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("neoconf").setup()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities())

			require("fidget").setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"clangd",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							root_dir = function()
								return vim.env.PWD
							end,
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = {
											"vim"
										},
										disable = {
											"lowercase-global"
										},
									}
								}
							}
						})
					end,
				}
			})
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
						{ name = "cody" },
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
					},
					{
						{ name = "buffer" },
					})
			})
			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
			local lspconfig = require('lspconfig')
			lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup,
				function(config)
					if config.name == "clangd" then
						config.cmd = { "/usr/bin/clangd-19" }
					end
				end)
		end
	},
}











--[[local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = { }
})


lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
})

local lsp = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "rafamadriz/friendly-snippets",
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            {
                "williamboman/mason.nvim",
                lazy = false,
                config = true,
            },
            -- Autocompletion
            {
                "hrsh7th/nvim-cmp",
                event = "InsertEnter",
                dependencies = {
                    "L3MON4D3/LuaSnip"
                },
                config = function()
                    local lsp_zero = require("lsp-zero")
                    lsp_zero.extend_cmp()


                    local cmp = require("cmp")
                    local cmp_action = lsp_zero.cmp_action()
                    local cmp_select = {behavior = cmp.SelectBehavior.Select}

                    cmp.setup({
                        sources = {
                            { name = "cody" },
                            {name = "path"},
                            {name = "nvim_lsp"},
                            {name = "nvim_lua"},
                            {name = "luasnip", keyword_length = 2},
                            {name = "buffer", keyword_length = 3},
                        },
                        formatting = lsp_zero.cmp_format(),
                        mapping = cmp.mapping.preset.insert({
                            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                            ["<C-Space>"] = cmp.mapping.complete(),
                        }),
                    })
                end
            },
        },
    },
}

return {
    lsp
}
--]]
