vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Set working directory on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local file = data.file
    if file and file ~= "" then
      if vim.fn.isdirectory(file) == 1 then
        -- If it’s a directory, cd to it
        vim.cmd("cd " .. file)
      elseif vim.fn.filereadable(file) == 1 then
        -- If it’s a file, cd to its parent directory
        local parent_dir = vim.fn.fnamemodify(file, ":h")
        vim.cmd("cd " .. parent_dir)
      end
    end
  end,
  group = vim.api.nvim_create_augroup("SetWorkingDir", { clear = true }),
})

-- Bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.g.python3_host_prog = vim.fn.exepath('python') or 'python'
vim.wo.relativenumber = true

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- Load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
