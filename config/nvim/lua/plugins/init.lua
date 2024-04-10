return {
  {
    "nvim-orgmode/orgmode",
    opts = {
      org_agenda_files = "~/.local/share/orgmode/*",
      org_default_notes_file = "~/.local/share/orgmode/notes.org",
    },
    config = function(_, opts)
      require("orgmode").setup(opts)
    end,
  },
}
