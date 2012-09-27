require 'spec_helper'

describe GloballyUniqueNumber do
  describe '#next' do
  	it "provides unique numbers" do
      numbers = Array.new(10) { GloballyUniqueNumber.next }
      numbers.uniq.should have(10).items
    end
  end
end
