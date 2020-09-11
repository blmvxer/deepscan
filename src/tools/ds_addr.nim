import random, strutils

var
  badAddr: seq[string]

badAddr = @["10", "127", "224", "240"]

proc genAddr*(): string =
  randomize()
  var
     ip0 = rand(1..255)
     ip1 = rand(255)
     ip2 = rand(255)
     ip3 = rand(255)
  for i, v in badAddr:
    if intToStr(ip0) == v:
      ip0 = rand(1..255)
    elif intToStr(ip0) == "192" and intToStr(ip1) == "168":
      ip1 = rand(255)
    else:
      return (join([$ip0, $ip1, $ip2, $ip3], "."))
