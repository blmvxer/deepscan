import nativesockets, net, strutils, sequtils
import ../tools/ds_addr, fab


proc testSSH*(host: string, exploit: string): bool =
  var
    sock = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    ver: string
  try:
    echo ("Attempting SSH on " & host)
    sock.connect(host, Port(22), 250)
    green("[+] Connected!\n")
    ver = recvLine(sock, 250)
    yellow("SSH Version: " & ver)
  except:
    red("[!] " & getCurrentExceptionMsg() & "\n")
