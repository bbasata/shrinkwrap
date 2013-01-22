class BadWordsBlacklist
  def initialize(blacklisted_words)
    @blacklisted_words = blacklisted_words
  end

  def accept?(string)
    !reject?(string)
  end

  def reject?(string)
    blacklisted_words.any? { |word| string.include?(word) }
  end

  private
  attr_reader :blacklisted_words
end
