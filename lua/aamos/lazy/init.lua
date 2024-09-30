return {
	"ryanoasis/vim-devicons",
	{
		"nvim-lua/plenary.nvim",
		name = "plenary"
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function ()
			require('gitsigns').setup()
		end
	}
}
