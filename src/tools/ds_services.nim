import strutils, os, sequtils, streams

var
  serviceList*: seq[string]
  servicePorts*: seq[string]
  serviceDir = "../dicts/services.cfg"

proc readServices*() {.discardable.} =
  var
    fp = newFileStream(serviceDir, fmRead)
    line: string
  try:
    while fp.readLine(line):
      if line.split(':')[0] == "":
        discard
      elif line.split(':')[1] == "":
        discard
      else:
        serviceList.add(line.split(':')[0])
        servicePorts.add(line.split(':')[1])
  except:
    echo getCurrentExceptionMsg()
