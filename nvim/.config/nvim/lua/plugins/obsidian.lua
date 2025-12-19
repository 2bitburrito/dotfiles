return {
  "obsidian-nvim/obsidian.nvim",
  enabled = true,
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      enable = false,
    },
    completion = {
      blink = true,
      nvim_cmp = false,
      -- Set to false to disable new note creation in the picker
      create_new = true,
    },
    picker = {
      name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    workspaces = {
      {
        name = "coding",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Coding Vault",
      },
    },
  },
}
