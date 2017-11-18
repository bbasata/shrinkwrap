require 'number_encoder'
require 'text/levenshtein'

describe NumberEncoder do
  describe '#encode' do
    def encode(number)
      NumberEncoder.encode(number)
    end

    it 'produces a short string given a large number' do
      expect(encode(1_000_000_000).length).to be <= 7
    end

    it 'produces a lexicographically larger value for a larger number' do
      expect(encode(1_000_000_000)).to be > encode(999_999_999)
    end

    it 'uses the alphabet 0-9 and A-Z except the numbers 0 and 1, to avoid confusion with the letters O and I' do
      exclusions = ['0', '1']
      expected_alphabet = ('0'..'9').to_a + ('A'..'Z').to_a - exclusions

      first_encodings = Array.new(expected_alphabet.length) { |number| encode(number) }
      alphabet = first_encodings.map(&:chars).map(&:to_a).flatten.uniq

      expect(alphabet).to eq expected_alphabet
    end

    context 'producing sparse values that differ in at least 2 characters' do
      example { expect(Text::Levenshtein.distance(encode(999_999_999), encode(999_999_998))).to be >= 2 }
      example { expect(Text::Levenshtein.distance(encode(999_999_998), encode(999_999_997))).to be >= 2 }
      example { expect(Text::Levenshtein.distance(encode(999_999_997), encode(999_999_996))).to be >= 2 }
    end
  end

  describe '#normalize' do
    def normalize(code)
      NumberEncoder.normalize(code)
    end

    it 'replaces the number 0 with the letter O' do
      expect(normalize('0RIGAMI')).to eq 'ORIGAMI'
    end

    it 'replaces the number 1 with the letter I' do
      expect(normalize('OR1GAM1')).to eq 'ORIGAMI'
    end
  end
end
