th.git = th.git or {}
th.git.modified = ui.Style():fg("yellow"):bold()
th.git.added = ui.Style():fg("green"):bold()
th.git.untracked = ui.Style():fg("magenta"):bold()
th.git.deleted = ui.Style():fg("red"):bold()
th.git.updated = ui.Style():fg("cyan"):bold()
th.git.ignored = ui.Style():fg("darkgray")

require("git"):setup({
  order = 1500,
})
