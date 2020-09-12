import ds_import, os, strutils

var
  services: seq[string]
  arguments = commandLineParams()

services = @["ftp", "ssh", "telnet", "winbox"]

proc help() =
  echo ("Commands: --test-useserv, --test-testserv , --test-servconf")
  quit(0)

proc testUseService() =
  echo ("Debug: Testing useService(service) and readService()\n")
  readServices()
  for service in services:
    echo service
    echo useService(service)
    echo "\n"

proc testTestService() =
  echo ("Debug: Testing testService(host, service)\n")
  var
    host = "172.217.164.110"
  for service in services:
    testService(host, service)
  echo "\n"

proc testServConf() =
  echo("Debug: Testing readService()\n")
  readServices()
  echo(serviceList)
  echo(servicePorts)
  echo("\n")
  echo("Debug: Testing sanitizeSeq(seq[string])\n")
  serviceList = sanitizeSeq(serviceList)
  servicePorts = sanitizeSeq(servicePorts)
  echo(serviceList)
  echo(servicePorts)
  echo("\n")
  echo("Debug: Repopulating\n")
  readServices()
  echo(serviceList)
  echo(servicePorts)
  echo("\n")

for arg in arguments:
  if "--test-useserv" in arg:
    testUseService()
  elif "--test-testserv" in arg:
    testTestService()
  elif "--test-servconf" in arg:
    testServConf()
  elif "--test-all" in arg:
    testServConf()
    testUseService()
    testTestService()
  else:
    help()
