require 'number_encoder'

class BadWordsBlacklist

  def initialize(blacklisted_words)
    @blacklisted_words = blacklisted_words
  end

  def take_until_clean(&block)
    loop do
      short_path = yield
      return short_path unless blacklisted_words.any? { |word| short_path.include?(word) }
    end
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

class ShortPathFilter
  def initialize(rule)
    @rule = rule
  end

  def first_good(&block)
    loop do
      short_path = yield
      return short_path if rule.accept?(short_path)
    end
  end

  private
  attr_reader :rule
end

BAD_WORDS_BLACKLIST = BadWordsBlacklist.new %w[ foo bar ]
SHORT_PATH_FILTER = ShortPathFilter.new(BAD_WORDS_BLACKLIST)

 module UrlShortener
   def self.shorten(long_url)
     short_path = SHORT_PATH_FILTER.first_good {
       unique_number = GloballyUniqueNumber.next
       NumberEncoder.encode(unique_number)
     }
     { :long_url => long_url, :short_path => short_path }
   end
 end
