class BadWordsDenylist
  def initialize(denylisted_words)
    @denylisted_words = denylisted_words
  end

  def accept?(string)
    !reject?(string)
  end

  def reject?(string)
    denylisted_words.any? { |word| string.include?(word) }
  end

  private
  attr_reader :denylisted_words
end
