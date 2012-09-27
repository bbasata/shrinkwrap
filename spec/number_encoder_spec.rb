require 'number_encoder'

describe NumberEncoder, '#encode' do
  it 'produces a short string given a large number' do
    NumberEncoder.encode(1_000_000_000).length.should be < 7 
  end

  it 'produces a lexicographically larger value for a larger number' do
  	NumberEncoder.encode(1_000_000_000).should be > NumberEncoder.encode(999_999_999)
  end
end
