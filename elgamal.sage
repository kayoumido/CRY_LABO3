
def genParams():
    """
    Generates parameters to be used in the additive El Gamal construction
    @rtype: (ZZ, ZZ or Zp)
    @returns: a tuple consisting of the prime number p and a generator g of Zp
    """
    return #TODO (p, g)
    
    
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
    return #TODO (a,A)


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
    @rtype: TODO
    @returns: the ciphertext
    """
    return #TODO
    
def decrypt(c, a, p, g):
    """
    Decrypts the ciphertext c under the private key a
    @type c: TODO
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
    return #TODO


