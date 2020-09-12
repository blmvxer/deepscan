import nativesockets, net, fab


proc testService*(host: string, service: string, port: int): string =
  var
    sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    ver: string
  try:
    echo ("Attempting " & service & " on " & host)
    sock.connect(host, Port(port), 250)
    green("[+] Connected!\n")
    ver = recvLine(sock, 250)
    yellow("SSH Version: " & ver)
  except:
    red("[!] " & getCurrentExceptionMsg() & "\n")
  finally:
    sock.close()
