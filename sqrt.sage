from Crypto.Util.number import long_to_bytes, bytes_to_long 
from math import sqrt



def keyGen():
    p = random_prime(2^1024)
    q = random_prime(2^1024)
    return ((p, q), p*q) #TODO = private key


def encrypt(m, n):
    m += b'\x00'*50
    m = bytes_to_long(m)
    return (m^2 % n)


def decrypt(c, key):
    (p, q), n = key

    P = Integers(p)
    Q = Integers(q)

    cp = P(c)
    cq = Q(c)

    cps = cp.sqrt(all=True)
    cqs = cq.sqrt(all=True)

    for cpp in cps:
        for cqq in cqs:
            r = long_to_bytes(crt([cpp.lift(), cqq.lift()], [p, q]))

            # since we do not know wich root contains the decrypted message,
            # we need to check the last 50 bytes for the redundancy we added 
            # when encrypting           
            if r[-50:] == b'\x00'*50:
                return r[:-50]



def main():
    
    m = b"We've known each other for so long.\n    Your heart's been aching but you're too shy to say it.\n    Inside we both know what's been going on."

    key = keyGen()
    (p, q), n = key

    # print("{}\n\n\n\n".format(key))
    c = encrypt(m, key[1])

    print(decrypt(c, key))


if __name__ == '__main__':
    main()
