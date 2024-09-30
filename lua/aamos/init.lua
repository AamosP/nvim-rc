require("aamos.set")
require("aamos.remap")
require("aamos.lazy_init")

ColorMyPencils("rose-pine-moon")

local dap = require("dap")
dap.adapters.c = {
	type = "executable",
	command = "/usr/bin/gdb",
	args = { "-i", "dap" }
}

dap.configurations.c = {
	{
		type = "c",
		request = "launch",
		name = "C_Launch",
		program = function()
			local path = vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file"
			})
			return (path and path ~= "") and path or dap.ABORT
		end
	}
}

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
	cmd = { "/usr/bin/clangd-19" }
})

local augroup = vim.api.nvim_create_augroup
local AamosGroup = augroup("Aamos", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
	group = AamosGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]]
})

autocmd("LspAttach", {
	group = AamosGroup,
	callback = function(ev)
		local opts = { buffer = ev.buf, remap = true }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end,
})
