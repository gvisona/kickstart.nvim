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

-----------------------------------------------------------------------------
-- Rendering in Browser
-----------------------------------------------------------------------------
-- Ensure that gh extension install yusukebe/gh-markdown-preview is installed for previews in browser

return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = false,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = 'Alexandria',
          path = '~/Obsidian/Alexandria',
          overrides = {
            notes_subdir = 'Zettelkasten',
            templates = {
              folder = 'Templates',
            },
            attachments = {
              img_folder = 'Files',
            },
          },
        },
        {
          name = 'WorkNotes',
          path = '~/Obsidian/WorkNotes',
          overrides = {
            notes_subdir = 'Notes',
            templates = {
              folder = 'Templates',
            },
            attachments = {
              img_folder = 'Images',
            },
          },
        },
      },
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
      new_notes_location = 'notes_subdir',

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        print 'title'
        print(title)
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.date '%Y_%m_%d') .. '-' .. suffix
      end,

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix '.md'
      end,

      disable_frontmatter = false,

      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end
        --
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        --
        -- local out = {}
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        -- img_folder = 'Files', -- This is the default

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format('%s-', os.time())
        end,

        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },
      --   mappings = {
      --     -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      --     ['gf'] = {
      --       action = function()
      --         return require('obsidian').util.gf_passthrough()
      --       end,
      --       opts = { noremap = false, expr = true, buffer = true },
      --     },
      --     -- Toggle check-boxes.
      --     ['<leader>ch'] = {
      --       action = function()
      --         return require('obsidian').util.toggle_checkbox()
      --       end,
      --       opts = { buffer = true },
      --     },
      --   },
    },
    config = function(plugin, opts)
      require('obsidian').setup(opts)
      vim.keymap.set('n', '<leader>on', '<cmd>Obsidian new_from_template<cr>', { desc = 'New [O]bsidian [N]ote' })
      vim.keymap.set('n', '<leader>so', '<cmd>Obsidian search<cr>', { desc = '[S]earch [O]bsidian notes' })
      vim.keymap.set('n', '<leader>os', '<cmd>Obsidian quick_switch<cr>', { desc = '[O]bsidian quick [S]witch' })
      vim.keymap.set('n', '<leader>ob', '<cmd>Obsidian backlinks<cr>', { desc = 'Location list of [O]bsidian [B]acklinks' })
      vim.keymap.set('n', '<leader>ot', '<cmd>Obsidian template<cr>', { desc = '[O]bsidian [T]emplate' })
      vim.keymap.set('n', '<leader>oi', '<cmd>Obsidian paste_img<cr>', { desc = '[O]bsidian paste [I]mage' })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    -- If some packages are missing, go the the install folder (e.g. `.local/share/nvim/lazy/markdown-preview.nvim`)
    -- and run `npm install`
    'iamcco/markdown-preview.nvim', -- requires the '@chemzqm/neovim' node module
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
        desc = '[M]arkdown [P]review',
      },
    },
  },
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      dirs = {
        ['~/Obsidian/Alexandria'] = {
          -- template = 'template for this project',

          dir_path = 'Files',
          -- filetypes = { -- filetype options nested inside dirs
          --   markdown = {
          --     template = 'markdown template',
          --   },
          -- },
          --
          -- files = { -- file options nested inside dirs
          --   ['readme.md'] = {
          --   },
          -- },
        },
        ['~/Obsidian/WorkNotes'] = {
          -- template = 'template for this project',

          dir_path = 'Images',
          -- filetypes = { -- filetype options nested inside dirs
          --   markdown = {
          --     template = 'markdown template',
          --   },
          -- },
          --
          -- files = { -- file options nested inside dirs
          --   ['readme.md'] = {
          --   },
          -- },
        },
      },
    },
    keys = {
      -- suggested keymap
      { '<leader>np', '<cmd>PasteImage<cr>', desc = '[N]ote [P]aste image from system clipboard' },
    },
  },
}
