from Crypto.Util.number import long_to_bytes, bytes_to_long 


def genParams():
    """
    Generates parameters to be used in the additive El Gamal construction

    @rtype: (ZZ, ZZ or Zp)
    @returns: a tuple consisting of the prime number p and a generator g of Zp
    """
    # generate the prime number p and Zp
    # TODO Make sure p is greater than 2**3072
    #       Possible solution: https://stackoverflow.com/questions/34140589/how-to-get-a-prime-of-a-given-length-in-sage
    p = random_prime(2**3072, proof=False)
    Zp = Integers(p)

    # get a generator of Zp
    # Note: Atm it will always return 1!
    g = Zp.gen()

    return (p, g)
    
    
def keyGen(p, g):
    """
    Generates a private/public key pair. 

    @type p: ZZ
    @param p: The prime number p defining Zp
    @type g: ZZ or Zp
    @param g: a generator of Zp

    @rtype: (ZZ, ZZ or Zp)
    @returns: a tuple consisting of the private key a and the public key A
    """

    Zp = Integers(p)

    # generate private key
    a = Zp.random_element()
 
    # generate public key
    A = (g^a)%p

    return (a, A)


def encrypt(m, A, p, g):
    """
    Encrypts the message m under the public key A

    @type m: bytes
    @param m: The message to encrypt.
    @type A: ZZ or Zp
    @param A: the public key under which we encrypt
    @type p: ZZ
    @param p: The prime number p defining Zp
    @type g: ZZ
    @param g: a generator of Zp

    @rtype: (ZZ, ZZ)
    @returns: the ciphertext
    """
    b, B = keyGen(p, g)
    M = bytes_to_long(m)

    return ((g^b)%p, (M*(A)^b)%p)
    
def decrypt(c, a, p, g):
    """
    Decrypts the ciphertext c under the private key a

    @type c: (ZZ, ZZ)
    @param c: The ciphertext to decrypt
    @type a: ZZ
    @param a: the private key under which we decrypt
    @type p: ZZ
    @param p: The prime number p defining Zp
    @type g: ZZ
    @param g: a generator of Zp
    @rtype: bytes
    @returns: the plaintext
    """
    # depact the cypher text
    u, v = c
    return long_to_bytes((v/(u)^a)%p)


def main():
    p, g = genParams()

    a, A = keyGen(p, g)

    c = encrypt(b'Complexe message', A, p, g)

    m = decrypt(c, a, p, g)

if __name__ == '__main__':
    main()