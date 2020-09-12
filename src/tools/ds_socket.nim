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
  servPort = checkService(service)
  if servPort.len == 3:
    for port in servPort:
      connectService(host, service, parseInt(port))
  else:
    connectService(host, service, parseInt(servPort[1]))


