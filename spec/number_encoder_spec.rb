require 'number_encoder'

describe NumberEncoder do
  describe '#encode' do
    def encode(number)
      NumberEncoder.encode(number)
    end
  
    it 'produces a short string given a large number' do
      encode(1_000_000_000).length.should be <= 7 
    end

    it 'produces a lexicographically larger value for a larger number' do
      encode(1_000_000_000).should be > encode(999_999_999)
    end

    it 'uses the alphabet 0-9 and A-Z except the numbers 0 and 1, to avoid confusion with the letters O and I' do
      exclusions = ['0', '1']
      expected_alphabet = ('0'..'9').to_a + ('A'..'Z').to_a - exclusions

      first_encodings = Array.new(expected_alphabet.length) { |number| encode(number) }
      alphabet = first_encodings.map(&:chars).map(&:to_a).flatten.uniq
      
      alphabet.should == expected_alphabet
    end

    context 'producing sparse values that differ in at least 2 characters' do
      example { Text::Levenshtein.distance(encode(999_999_999), encode(999_999_998)).should be >= 2 }
      example { Text::Levenshtein.distance(encode(999_999_998), encode(999_999_997)).should be >= 2 }
      example { Text::Levenshtein.distance(encode(999_999_997), encode(999_999_996)).should be >= 2 }
    end
  end

  describe '#normalize' do
    def normalize(code)
      NumberEncoder.normalize(code)
    end

    it 'replaces the number 0 with the letter O' do
      normalize('0RIGAMI').should == 'ORIGAMI'
    end

    it 'replaces the number 1 with the letter I' do
      normalize('OR1GAM1').should == 'ORIGAMI'
    end
  end
end