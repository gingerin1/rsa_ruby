class RSA
  def initialize(modulus, exponent, phi)
    @e = exponent
    @n = modulus
    a, b = calculateBezout(phi, exponent)
    @d = b
  end

  def encrypt(plaintext)
    ciphertext = ""
    plaintext.each_char { |c| ciphertext += ((c.ord**@e) % @n ).chr }
    return ciphertext
  end

  def decrypt(ciphertext)
    plaintext = ""
    ciphertext.each_char { |c| plaintext += ((c.ord**@d) % @n ).chr }
    return plaintext
  end

private
  def calculateBezout(a, b)  
    return 1, 0 if b == 0

    # recurse: a = q*b + r
    q, r = a.divmod b
    s, t = calculateBezout(b, r)

    # compute and return coefficients:
    # gcd(a, b) == gcd(b, r) == s*b + t*r == s*b + t*(a - q*b)
    return t, s - q * t 
  end
end
