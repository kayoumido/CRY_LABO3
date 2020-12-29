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
    # g = Zp.gen()
    g = Zp.random_element()

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
    A = (a * g) % p

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

    return (B, (M + b * A) % p)
    
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
    # depack the cypher text
    u, v = c

    return long_to_bytes((v - a * u) % p)


def main():
    p, g = genParams()

    print(type(p))
    a, A = keyGen(p, g)

    print(a)
    hacked_a = (A/g)

    print(a == hacked_a)
    c = encrypt(b'Complexe message', A, p, g)
    # print(c)
    m = decrypt(c, a, p, g)
    # print(m)

    print()
    print()

    g1 = 4791646413672117730804786142776775223841786565908134851831593089801506744480368975272116980986924886384533811290342358724329483056354741205452622429244028751581131933783339363906972701871167178078318030920568988964762412717712264846985921182718722563789037937103985569939157234886562910778568373159425529970515182196397063503305650700710931867202266846329672649873732583923997647569016131292921851902583721937324347027723575986163208528315862579615841572436231089824215992751498263022919420289451600620520981410062253833402197721011996662223811928711361402294865038847602172666890558839823953065949147647827618346944
    A1 = 12520232768949022046066753515508465549859602287600907255746923063500935787620338253462265868988040482212576628296975369341807018657878819882419310564713757273767998504113885318563628945027093060421314019236734622375125066450800810292537776738999120560562859322488916250291767604356288330926025567311965191957651478316937604692451527337122955178863553837503272720975323218003576034490566073191813186713571239439554999200311423243920894186780818221216257178477707812735616008858510479893058934954792957371978490379794702991573018967429611712703395935259738986433175912009045432083874758391174255504161566965063318054457
    p1 = 16417894794630379088560906272554399886870342736794381549205354011075317437731237697103120223724136787005229990590274262626811086453466418776998900008989146922530673003413984030039013948101035655465636437612381683409269732350003501741652025632618020096836063609040834801339519701979695722160984424471147091564767288399784552920677437903985655565360630449268719941461570772704933794939127009120354782724372653100330493976696051753598719750966999208515496936222505869678545782097030945700943032051235794370984335498235251442374894699610380397295513465734635134469175778522837548145418066881082608243343133875498527211361
    c1 = (9893163778554775286602234897905792029746557395008389318351060935038508519550773265655402446554593409192159251015735994700167254714409063601493536666352750721362381396567259555613859301591919683539676135375015857103247061031191009126892252957255120429288435546024649468271443444792831687577025115179903470527230413193023950514669150125518569156759886303750393497795538384886648627393899438197617282906867352604763088194628773991678630408865539505368592982738315514950772847867874137282311181133888923000449762002853834425183142456191986307005030687534677424267013455369615310384053696013892829973777186760090684989503, 14209837743630791768474782411203399370976357738476925289910385098530444065850444529788145670586267287952650215644812132014962680269446617757753806219543817918503174810691388818279457623323216267843735550230948205564448290327108351057044077131274615069453175931909216855742350987446635055062277654417151542909486710647961794969449802255457520266809397070036551066518710186549589161517754444432526407086677053753183142330081702757150822847779312011850074712876345193488246964001416143590276348800023546878104839663822168870393053473375968238206675828337585912272063685699269041234986996171452114618513542744065169011815)
    
    a1 = A1 / g1 % p1

    print(a1)
    M = decrypt(c1, a1, p1, g1)
    print(M)

if __name__ == '__main__':
    main()