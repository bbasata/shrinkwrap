module NumberEncoder
  ALPHABET = (0..9).to_a + ('A'..'Z').to_a

  def self.encode(number)
  	# Using the radix gem, convert to a base 'n' number, where 'n' is the size of ALPHABET
  	number.b(ALPHABET).to_s
  end
end