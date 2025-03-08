-- -------------------------------------------------------------------------------
-- --                           Folding section
-- -------------------------------------------------------------------------------
--
-- -- Use <CR> to fold when in normal mode
-- -- To see help about folds use `:help fold`
-- vim.keymap.set('n', '<CR>', function()
--   -- Get the current line number
--   local line = vim.fn.line '.'
--   -- Get the fold level of the current line
--   local foldlevel = vim.fn.foldlevel(line)
--   if foldlevel == 0 then
--     vim.notify('No fold found', vim.log.levels.INFO)
--   else
--     vim.cmd 'normal! za'
--     vim.cmd 'normal! zz' -- center the cursor line on screen
--   end
-- end, { desc = '[P]Toggle fold' })
--
-- local function set_foldmethod_expr()
--   -- These are lazyvim.org defaults but setting them just in case a file
--   -- doesn't have them set
--   if vim.fn.has 'nvim-0.10' == 1 then
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
--     vim.opt.foldtext = ''
--   else
--     vim.opt.foldmethod = 'indent'
--     vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
--   end
--   vim.opt.foldlevel = 99
-- end
--
-- -- Function to fold all headings of a specific level
-- local function fold_headings_of_level(level)
--   -- Move to the top of the file
--   vim.cmd 'normal! gg'
--   -- Get the total number of lines
--   local total_lines = vim.fn.line '$'
--   for line = 1, total_lines do
--     -- Get the content of the current line
--     local line_content = vim.fn.getline(line)
--     -- "^" -> Ensures the match is at the start of the line
--     -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
--     -- "%s" -> Matches any whitespace character after the "#" characters
--     -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
--     if line_content:match('^' .. string.rep('#', level) .. '%s') then
--       -- Move the cursor to the current line
--       vim.fn.cursor(line, 1)
--       -- Fold the heading if it matches the level
--       if vim.fn.foldclosed(line) == -1 then
--         vim.cmd 'normal! za'
--       end
--     end
--   end
-- end
--
-- local function fold_markdown_headings(levels)
--   set_foldmethod_expr()
--   -- I save the view to know where to jump back after folding
--   local saved_view = vim.fn.winsaveview()
--   for _, level in ipairs(levels) do
--     fold_headings_of_level(level)
--   end
--   vim.cmd 'nohlsearch'
--   -- Restore the view to jump to where I was
--   vim.fn.winrestview(saved_view)
-- end
--
-- -- Keymap for unfolding markdown headings of level 2 or above
-- -- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- -- zj, zk, zl, z; and zu respectively lamw25wmal
-- vim.keymap.set('n', 'zu', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- vim.keymap.set("n", "<leader>mfu", function()
--   -- Reloads the file to reflect the changes
--   vim.cmd 'edit!'
--   vim.cmd 'normal! zR' -- Unfold all headings
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Unfold all headings level 2 or above' })
--
-- -- gk jummps to the markdown heading above and then folds it
-- -- zi by default toggles folding, but I don't need it lamw25wmal
-- vim.keymap.set('n', 'zi', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- Difference between normal and normal!
--   -- - `normal` executes the command and respects any mappings that might be defined.
--   -- - `normal!` executes the command in a "raw" mode, ignoring any mappings.
--   vim.cmd 'normal gk'
--   -- This is to fold the line under the cursor
--   vim.cmd 'normal! za'
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Fold the heading cursor currently on' })
--
-- -- Keymap for folding markdown headings of level 1 or above
-- vim.keymap.set('n', 'zj', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- vim.keymap.set("n", "<leader>mfj", function()
--   -- Reloads the file to refresh folds, otheriise you have to re-open neovim
--   vim.cmd 'edit!'
--   -- Unfold everything first or I had issues
--   vim.cmd 'normal! zR'
--   fold_markdown_headings { 6, 5, 4, 3, 2, 1 }
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Fold all headings level 1 or above' })
--
-- -- Keymap for folding markdown headings of level 2 or above
-- -- I know, it reads like "madafaka" but "k" for me means "2"
-- vim.keymap.set('n', 'zk', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- vim.keymap.set("n", "<leader>mfk", function()
--   -- Reloads the file to refresh folds, otherwise you have to re-open neovim
--   vim.cmd 'edit!'
--   -- Unfold everything first or I had issues
--   vim.cmd 'normal! zR'
--   fold_markdown_headings { 6, 5, 4, 3, 2 }
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Fold all headings level 2 or above' })
--
-- -- Keymap for folding markdown headings of level 3 or above
-- vim.keymap.set('n', 'zl', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- vim.keymap.set("n", "<leader>mfl", function()
--   -- Reloads the file to refresh folds, otherwise you have to re-open neovim
--   vim.cmd 'edit!'
--   -- Unfold everything first or I had issues
--   vim.cmd 'normal! zR'
--   fold_markdown_headings { 6, 5, 4, 3 }
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Fold all headings level 3 or above' })
--
-- -- Keymap for folding markdown headings of level 4 or above
-- vim.keymap.set('n', 'z;', function()
--   -- "Update" saves only if the buffer has been modified since the last save
--   vim.cmd 'silent update'
--   -- vim.keymap.set("n", "<leader>mf;", function()
--   -- Reloads the file to refresh folds, otherwise you have to re-open neovim
--   vim.cmd 'edit!'
--   -- Unfold everything first or I had issues
--   vim.cmd 'normal! zR'
--   fold_markdown_headings { 6, 5, 4 }
--   vim.cmd 'normal! zz' -- center the cursor line on screen
-- end, { desc = '[P]Fold all headings level 4 or above' })
--
-- -----------------------------------------------------------------------------
-- --                        End Folding section
-- -----------------------------------------------------------------------------

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      {
        '<leader>mp',
        ft = 'markdown',
        '<cmd>MarkdownPreviewToggle<cr>',
        desc = 'Markdown Preview',
      },
    },
  },
}
