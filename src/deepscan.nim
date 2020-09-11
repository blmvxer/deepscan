import tools/ds_import, os, strutils

var
  arguments = commandLineParams()
  ssh: bool
  tel: bool

ssh = false
tel = false

proc main() =
  for arg in arguments:
    if "--ssh" in arg:
      ssh = true
    elif "--telnet" in arg:
      tel = true
    else:
      echo ("Try --help\n")
main()
