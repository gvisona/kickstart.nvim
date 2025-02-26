return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'Alexandria',
        path = '~/Obsidian/Alexandria',
        overrides = {
          notes_subdir = 'Zettelkasten',
          templates = {
            folder = 'Templates',
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
    disable_frontmatter = false,

    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      -- if note.title then
      --   note:add_alias(note.title)
      -- end
      --
      -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      --
      local out = {}
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
      img_folder = 'Files', -- This is the default

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
  },
  config = function(plugin, opts)
    require('obsidian').setup(opts)
    vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNewFromTemplate<cr>', { desc = 'New [O]bsidian [N]ote' })
    vim.keymap.set('n', '<leader>so', '<cmd>ObsidianSearch<cr>', { desc = '[S]earch [O]bsidian notes' })
    vim.keymap.set('n', '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[O]bsidian quick [S]witch' })
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', { desc = 'Location list of [O]bsidian [B]acklinks' })
    vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTemplate<cr>', { desc = '[O]bsidian [T]emplate' })
    vim.keymap.set('n', '<leader>oi', '<cmd>ObsidianPasteImg<cr>', { desc = '[O]bsidian paste [I]mage' })
  end,
}
