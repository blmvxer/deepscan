import tools/ds_import, os, strutils

var
  arguments = commandLineParams()
  ssh: bool
  tel: bool
  port: int

ssh = false
tel = false

proc argParser(service: string): bool =
  for arg in arguments:
    if "--ssh" in arg and service == "ssh":
      ssh = true
      port = 22
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
      discard testService(genAddr(), "ssh", port)
  else:
    quit(0)
main()
