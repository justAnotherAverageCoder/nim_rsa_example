import std/math
import std/random

import bigints 




proc uintRemain(num1: uint, num2: uint): uint =
    return num1 - num2

proc uintDiv(num1: uint, num2: uint): tuple =

    var temp = num2
    var count: uint
    var ret: tuple[divided: uint, remainder: uint]
    count = 1

    if num2 >= num1:
        return ret

    if num2 == 0 or num1 == 0:
        return ret

    while (temp + num2) <= num1:
        temp = temp + num2
        count = count + 1
    ret.divided = count
    ret.remainder = uintRemain(num1, count * num2)
    return ret




proc isPrime(num: uint): bool =
    for x in 2 .. uintDiv(num, 2).divided:
        if uintDiv(num, x).remainder == 0:
            return false
    return true




proc genPrime(): uint =
    var ret: uint
    ret = 4
    while isPrime(ret) == false:
        ret = uint(rand(100 .. 555))
    return ret


proc genPub(totient: uint): uint =
    var ret: uint
    while true:
        if ret < totient and ret.isPrime() == true and totient.uintDiv(ret).remainder != 0:
            return ret
        else:
            ret = (uint(rand(1000 .. 5555)))   



proc encMsg(msg: uint, pub: uint, n: uint): BigInt =
    var big: BigInt
    var bigMsg = msg.initBigInt


    big = bigMsg.pow(pub)
    big = big.mod(n.initBigInt)

    return big



proc decMsg(msg: BigInt, dec: uint, n: uint): BigInt =
    var big: BigInt
    var bigMsg = msg.initBigInt


    big = bigMsg.pow(dec)
    big = big.mod(n.initBigInt)

    return big



proc modInv(a0, b0: int): int =
    var (a, b, x0) = (a0, b0, 0)
    result = 1
    if b == 1: return
    while a > 1:
        result = result - (a div b) * x0
        a = a mod b
        swap a, b
        swap x0, result
    if result < 0: result += b0


proc genPriv(pub: uint, tot: uint): uint =
    return uint(modInv(int(pub), int(tot)))


proc main() = 
    randomize()
    let p = genPrime()
    let q = genPrime()
    let productN = p * q
    let totientT = (p - 1) * (q - 1)


    let pub = genPub(totientT)
    let priv = genPriv(pub, totientT)


    var msg: string
    msg = "hello"

    var enced: seq[BigInt]
    var deced: seq[BigInt]


    for x in msg:
        enced.add(encMsg(uint(x), pub, productN))

    for y in enced:
        deced.add(decMsg(y, priv, productN))

    
    echo "ENC MSG > ", enced

    echo "DEC MSG > ", deced



   




main()