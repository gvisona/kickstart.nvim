-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ray-x/lsp_signature.nvim', -- Show function signature in a window in insert mode
    event = 'InsertEnter',
    opts = {
      bind = true,
      handler_opts = {
        border = 'single',
      },
    },
    -- or use config
    -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
  },
}
