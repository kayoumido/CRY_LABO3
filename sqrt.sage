from Crypto.Util.number import long_to_bytes, bytes_to_long 

def keyGen():
    p = random_prime(2^1024)
    q = random_prime(2^1024)
    return (TODO, p*q) #TODO = private key

def encrypt(m, n):
    m += b'\x00'*50
    m = bytes_to_long(m)
    return (m^2 % n)


def decrypt(c, TODO):
    #TODO
    return m #return plaintext
