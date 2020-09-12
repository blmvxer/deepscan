import tools/ds_import, os, strutils

var
  arguments = commandLineParams()
  ssh: bool
  tel: bool
  port: int
  service: string

proc argParser(): bool =
  for arg in arguments:
    if "--ssh" in arg:
      service = "ssh"
      port = 22
      return true
    elif "--tel" in arg:
      service = "telnet"
      port = 23
      return true
    else:
      echo ("Try --help\n")
      return false

proc main() =
  if argParser() == true:
    while true:
      discard testService(genAddr(), service, port)
  else:
    quit(0)
main()
