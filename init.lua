local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------------------
--- LEADERS --
-----------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-----------------------------------------------------------------------
--- LEADERS --
-----------------------------------------------------------------------

require("lazy").setup({
  spec = {
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "vim", "go", "python", "javascript" },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("telescope").setup({})
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
require("nvim-treesitter.configs").setup({
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,  -- to use the jump list
      goto_next_start = {
        ["]m"] = "@function.outer",  -- Next function start
      },
      goto_previous_start = {
        ["[m"] = "@function.inner",  -- Previous function start
      },
    },
  },
})

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.relativenumber = true
vim.o.number = true

vim.opt.scrolloff = 10

vim.keymap.set('n', '<Leader>r', vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>t', vim.lsp.buf.hover, { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-j>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "<C-j>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<C-o>', '"_diwP', { noremap = true, silent = true })
vim.keymap.set('n', ']m', function() vim.cmd("normal! ]m") end, { desc = "Next Function" })
vim.keymap.set('n', '[m', function() vim.cmd("normal! [m") end, { desc = "Previous Function" })
vim.api.nvim_set_keymap('n', '<leader>[', '?func.*{<CR>:noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>]', '/func.*{<CR>:noh<CR>', { noremap = true, silent = true })
vim.keymap.set("n", 'gyy', '^v g_y', { noremap = true, silent = true })
