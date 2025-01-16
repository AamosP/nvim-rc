local opt = vim.opt

opt.inccommand = "split"

-- Search settings
opt.smartcase = true
opt.ignorecase = true

-- Personal Preferences
opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.wrap = false

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.cmdheight = 1

opt.guicursor = "a:block"

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
