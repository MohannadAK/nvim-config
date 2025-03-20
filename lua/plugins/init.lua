return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic",
        hide_cursor = false,
        stop_eof = true,
        respect_scrolloff = true,
        cursor_scrolls_alone = false,
      })

      local neoscroll = require("neoscroll")
      local mappings = {
        ["<C-u>"] = function() neoscroll.scroll(-vim.wo.scroll, { move_cursor = true, duration = 50 }) end,
        ["<C-d>"] = function() neoscroll.scroll(vim.wo.scroll, { move_cursor = true, duration = 50 }) end,
        ["<C-b>"] = function() neoscroll.scroll(-vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 75 }) end,
        ["<C-f>"] = function() neoscroll.scroll(vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 75 }) end,
      }

      for key, func in pairs(mappings) do
        vim.keymap.set("n", key, func, { silent = true })
      end
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false, -- Load immediately to ensure commands are available
    opts = {
      view = {
        side = "left",
        width = 30,
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
          },
        },
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      -- Open nvim-tree on startup after setting the directory
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local file = data.file
          if file and file ~= "" and (vim.fn.isdirectory(file) == 1 or vim.fn.filereadable(file) == 1) then
            vim.cmd("NvimTreeOpen")
            vim.cmd("wincmd p")
          end
        end,
      })
    end,
  },

-- Add presence.nvim for Discord Rich Presence
{
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      require("presence").setup({
        neovim_image_text = "Who wrote this shit?",
        main_image = "neovim",
        enable_line_number = false,
        buttons = { { label = "GitHub", url = "https://github.com/MohannadAK" } },
        -- log_level = "debug",
      })
    end
  },
}
