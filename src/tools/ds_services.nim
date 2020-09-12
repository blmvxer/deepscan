import strutils, streams, sequtils

const
  serviceDir* = "../dicts/services.cfg"

var
  serviceList*: seq[string]
  servicePorts*: seq[string]
  servicePayload*: seq[string]
  count: int
  servLen: int

servicePayload = @[]

proc sanitizeSeq*(dirty: seq[string]): seq[string] =
  if dirty.len != 0:
    return @[]
  else:
    return dirty

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
  finally:
    fp.close()

proc useService*(service: string): seq[string] {.discardable.} =
  count = 0
  servLen = serviceList.len()
  try:
    servicePayload = sanitizeSeq(servicePayload)
    for services in serviceList:
      if service == services:
        servicePayload.add(service)
        if servicePorts[count].contains(','):
          servicePayload.add(servicePorts[count].split(',')[0])
          servicePayload.add(servicePorts[count].split(',')[1])
        else:
         servicePayload.add(servicePorts[count])
      else:
        count = count + 1
  except:
    echo getCurrentExceptionMsg()
  finally:
    servicePorts = sanitizeSeq(servicePorts)
    serviceList = sanitizeSeq(serviceList)
    return servicePayload
