require 'radix/integer'

module NumberEncoder
  ALPHABET = ('0'..'9').to_a + ('A'..'Z').to_a - ['0', '1']

  def self.encode(number)
    # Using the radix gem, convert to a base 'n' number, where 'n' is the size of ALPHABET
    # Ensure that codes are sparse by ensuring the last two characters of the base 'n' number
    # are different for encode(n) and encode(n + 1)
    number = number * (ALPHABET.length + 1)
    Radix::Integer.new(number).to_s(ALPHABET)
  end

  def self.normalize(code)
    code.tr('01', 'OI')
  end
end
