local function get_github_repo(user, repo)
    local response = {}
    local url = "https://api.github.com/repos/" .. user .. "/" .. repo
    local body, code, headers = https.request {
        url = url,
        sink = ltn12.sink.table(response),
        protocol = "tlsv1"
    }

    if code ~= 200 then
        return nil
    end

    local repo_data = json.decode(table.concat(response))
    return repo_data
end

local function get_github_files(user, repo)
    local response = {}
    local url = "https://api.github.com/repos/" .. user .. "/" .. repo .. "/contents"
    local body, code, headers = https.request {
        url = url,
        sink = ltn12.sink.table(response),
        protocol = "tlsv1"
    }

    if code ~= 200 then
        return nil
    end

    local files_data = json.decode(table.concat(response))
    return files_data
end

local function get_github_file_content(user, repo, file)
    local response = {}
    local url = "https://api.github.com/repos/" .. user .. "/" .. repo .. "/contents/" .. file
    local body, code, headers = https.request {
        url = url,
        sink = ltn12.sink.table(response),
        protocol = "tlsv1"
    }

    if code ~= 200 then
        return nil
    end

    local file_data = json.decode(table.concat(response))
    return file_data
end

local function view_github(user, repo)
    local repo_data = get_github_repo(user, repo)
    if not repo_data then
        print("Error: Failed to fetch repository data")
        return
    end

    local files_data = get_github_files(user, repo)
    if not files_data then
        print("Error: Failed to fetch files data")
        return
    end
    local format_str = [[
    Repository: %s/%s
    Description: %s
    Stars: %s
    Forks: %s
    Clone URL: %s
    ]]
    local content = string.format(format_str, user, repo, repo_data.description, repo_data.stargazers_count,
        repo_data.forks_count, repo_data.clone_url)
    content = content .. "\n\n" .. "Files:\n"
    for _, file in ipairs(files_data) do
        content = content .. file.name .. "\n"
    end

    -- Create a new buffer and display the content
    local win_id = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(win_id, 0, -1, true, vim.split(content, "\n"))
    local bufnr = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'gitrepo')

    -- Map keys for navigating the repository
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':ViewGithubFile ' .. user ..
        ' ' .. repo .. ' <C-R>=getline(".")<CR><CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'o', ':ViewGithubFile ' .. user .. ' ' .. repo ..
        ' <C-R>=getline(".")<CR><CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'x', ':bdelete<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'u', ':call go_up()<CR>', { noremap = true, silent = true })
    -- Function to go up one level in the repository
    function go_up()
        local path = vim.api.nvim_buf_get_var(bufnr, "path")
        if path == '/' then
            return
        end
        path = path:match("(.*/)")
        if not path then
            path = '/'
        end
        local parts = vim.fn.split(path, '/')
        local user = parts[2]
        local repo = parts[3]
        vim.api.nvim_buf_set_var(bufnr, "path", path)
        view_github(user, repo)
    end
end
