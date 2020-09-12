import nativesockets, net, fab, strutils
import ds_services
var
  servPort: seq[string]

proc checkService(service: string): seq[string] =
  servPort = useService(service)
  return servPort

proc connectService(host: string, service: string, port: int) =
  var
    sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    ver: string
  try:
    echo ("Attempting " & service & " on " & host & ":" & $port)
    sock.connect(host, Port(port), 250)
    green("[+] Connected!\n")
    ver = recvLine(sock, 250)
    yellow("SSH Version: " & ver)

  except:
    red("[!] " & getCurrentExceptionMsg() & "\n")
  finally:
    sock.close()

proc testService*(host: string, service: string) =
  readServices() 
  servPort = checkService(service)
  if servPort.len == 3:
    connectService(host, service, parseInt(servPort[1]))
    connectService(host, service, parseInt(servPort[2]))
  else:
    connectService(host, service, parseInt(servPort[1]))


