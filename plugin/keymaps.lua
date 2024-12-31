local set = vim.keymap.set

set("n", "<C-h>", "<C-w><C-h>")
set("n", "<C-j>", "<C-w><C-j>")
set("n", "<C-k>", "<C-w><C-k>")
set("n", "<C-l>", "<C-w><C-l>")

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

set("n", "<CR>", function()
    --- @diagnostic disable-next-line: undefined-field
    if vim.opt.hlsearch:get() then
        vim.cmd.nohl()
        return ""
    else
        return "<CR>"
    end
end, { expr = true })

set("n", "<M-n>", "gt")
set("n", "<M-p>", "gT")

set("n", "<M-,>", "<C-w>5<")
set("n", "<M-.>", "<C-w>5>")
set("n", "<M-t>", "<C-w>+")
set("n", "<M-s>", "<C-w>-")

set("n", "<M-j>", function()
    if vim.opt.diff:get() then
        vim.cmd [[normal! ]c]]
    else
        vim.cmd [[m .+1<CR>==]]
    end
end)

set("n", "<M-k>", function()
    if vim.opt.diff:get() then
        vim.cmd [[normal! c]]
    else
        vim.cmd [[m .-2<CR>==]]
    end
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- vim.keymap.set("n", "<M-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<M-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "-", "<cmd>Oil<CR>")
