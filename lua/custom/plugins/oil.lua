return {
    {
        "stevearc/oil.nvim",
        --- @module "oil"
        --- @type oil.SetupOpts
        opts = {
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    if name == "../" or name == ".." then
                        return true
                    end
                    return false
                end
            },
            skip_confirm_for_simple_edits = true,
            preview_win = {
                disable_preview = function(filename)
                    local maxsize = 100000
                    local r = false
                    vim.uv.fs_stat(filename, function(stats)
                        if stats and not stats == nil then
                            if stats.size >= maxsize then
                                r = true
                            end
                        end
                    end)
                    return r
                end
            }
        },
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
    }
}
