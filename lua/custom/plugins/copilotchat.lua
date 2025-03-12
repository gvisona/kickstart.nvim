return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<M-y>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = '[C]hat with Copilot' },
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = '[E]xplain Code' },
      { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = '[R]eview Code' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = '[F]ix Code Issues' },
      { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = '[O]ptimize Code' },
      { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate [D]ocs' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate [T]ests' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit [M]essage' },
      { '<leader>zs', ':CopilotChatCommit<CR›', mode = 'v', desc = 'Generate Commit for [S]election' },
    },
  },
}
