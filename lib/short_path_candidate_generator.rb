class ShortPathCandidateGenerator
  include Enumerable

  def initialize(unique_number_sequence, encoder)
    @unique_number_sequence = unique_number_sequence
    @encoder = encoder
  end

  def each
    loop do
      unique_number = unique_number_sequence.next
      yield encoder.encode(unique_number)
    end
  end

  private
  attr_reader :unique_number_sequence, :encoder
end
