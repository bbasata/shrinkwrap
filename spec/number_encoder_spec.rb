require 'number_encoder'

describe NumberEncoder, '#encode' do
  it 'produces a short string given a large number' do
    NumberEncoder.encode(1_000_000_000).length.should be < 7 
  end

  it 'produces a lexicographically larger value for a larger number' do
  	NumberEncoder.encode(1_000_000_000).should be > NumberEncoder.encode(999_999_999)
  end

  it 'uses the alphabet 0-9 and A-Z except the numbers 0 and 1, to avoid confusion with the letters O and I' do
    exclusions = ['0', '1']
	  expected_alphabet = ('0'..'9').to_a + ('A'..'Z').to_a - exclusions

    first_encodings = (0...expected_alphabet.length).collect { |number| NumberEncoder.encode(number) }
    alphabet = first_encodings.uniq
    
    alphabet.should == expected_alphabet
  end
end
