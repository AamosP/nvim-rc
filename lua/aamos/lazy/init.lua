return {
    "ryanoasis/vim-devicons",
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    {
        "sourcegraph/sg.nvim",
        dependencies = {
            "plenary"
        },
        build = "nvim -l build/init.lua",
        config = function()
            require("sg").setup()
        end
    },
}
