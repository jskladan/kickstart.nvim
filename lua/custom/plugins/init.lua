-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'jskladan/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    init = function()
      -- Since the Claude code eats all the "normal" key combinations, lets add this to move out of it
      vim.keymap.set('t', '<C-q>', '<C-\\><C-n><C-w><C-p>', { desc = 'Exit terminal mode and move to the previous split' })
    end,
    config = true,
    opts = {
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = false,
        -- open_in_current_tab = false,
        -- keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
    keys = {
      { '<leader>a', nil, desc = 'AI/Claude Code' },
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      {
        '<leader>as',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles' },
      },
      -- Diff management
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },

  -- Intelligently reopen files at your last edit position. By default git, svn, and mercurial commit messages are ignored
  'vladdoster/remember.nvim',

  -- Load the colorscheme
  {
    'neanias/everforest-nvim',
    priority = 1000,
    init = function()
      local everforest = require 'everforest'
      everforest.setup {
        background = 'hard',
        transparent_background_level = 0,
        italics = true,
        disable_italic_comments = false,
        colours_override = function(palette)
          palette.bg0 = '#101115'
        end,
        on_highlights = function(hl, palette)
          hl.CurrentWord = { bg = '#2b2a2a' }
        end,
      }
      everforest.load()
    end,
    config = function()
      vim.cmd.colorscheme 'everforest'
    end,
  },

  -- File browser
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      sort_by = 'name',
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        icons = { show = { file = false } },
      },
      update_focused_file = {
        enable = true,
      },
      git = {
        ignore = false,
      },
    },
    init = function()
      -- disable netrw (required for the nvim-tree plugin)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      function NvimTree_smart_toggle()
        if require('nvim-tree.view').is_visible() then
          vim.cmd 'NvimTreeClose'
        else
          vim.cmd 'NvimTreeFindFile'
        end
      end

      vim.keymap.set('n', '<leader>e', NvimTree_smart_toggle, { desc = 'Toggle file [E]xplorer' })
    end,
  },
}
