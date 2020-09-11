import tools/ds_import, os, strutils

var
  arguments = commandLineParams()
  ssh: bool
  tel: bool

ssh = false
tel = false

proc argParser(service: string): bool =
  for arg in arguments:
    if "--ssh" in arg and service == "ssh":
      ssh = true
      return true
    elif "--telnet" in arg and service == "tel":
      tel = true
      return true
    else:
      echo ("Try --help\n")
      return false

proc main() =
  if argParser("ssh") == true:
    while true:
      discard testSSH(genAddr(), "exploit")
  else:
    quit(0)
main()
