import strutils, streams, sequtils

var
  serviceList*: seq[string]
  servicePorts*: seq[string]
  serviceDir = "../dicts/services.cfg"
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


proc useService*(service: string): seq[string] {.discardable.} =
  readServices()
  servicePayload = sanitizeSeq(servicePayload)
  count = 0
  servLen = serviceList.len()
  try:
    if service == serviceList[count]:
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
    return servicePayload
