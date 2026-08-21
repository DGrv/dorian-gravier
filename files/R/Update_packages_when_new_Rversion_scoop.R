oldlib <- "C:/Users/doria/scoop/persist/r/site-library"

ip <- installed.packages(lib.loc = oldlib)

pkgs <- rownames(ip)

length(pkgs)



old <- "C:/Users/doria/scoop/persist/r/site-library"
backup <- "C:/Users/doria/scoop/persist/r/site-library-old"

system2("powershell", c(
  "-NoProfile",
  "-Command",
  sprintf("Rename-Item -LiteralPath '%s' -NewName 'site-library-old'", old)
))

dir.create(old, recursive = TRUE, showWarnings = FALSE)





lib <- "C:/Users/doria/scoop/persist/r/site-library"

pkgs <- readLines("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/packages.txt")

install.packages(
  pkgs,
  lib = lib,
  dependencies = TRUE
)

