require 'spec_helper'

describe GloballyUniqueNumber, type: :model do
  describe '#next' do
    it "provides unique numbers" do
      numbers = Array.new(10) { GloballyUniqueNumber.next }
      expect(numbers.uniq.size).to eq 10
    end
  end
end
