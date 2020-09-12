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
      return true
    elif "--tel" in arg:
      service = "telnet"
      return true
    else:
      echo ("Try --help\n")
      return false

proc main() =
  if argParser() == true:
    while true:
      testService(genAddr(), service)
  else:
    quit(0)
main()
