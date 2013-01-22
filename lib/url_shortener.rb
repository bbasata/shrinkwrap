require 'bad_words_blacklist'
require 'number_encoder'
require 'short_path_candidate_generator'

class UrlShortener
  def self.shorten(long_url)
    short_path = short_path_candidate_generator.find { |short_path| bad_words_blacklist.accept?(short_path) }
    { :long_url => long_url, :short_path => short_path }
  end

  private

  def self.short_path_candidate_generator
    @short_path_candidate_generator ||= ShortPathCandidateGenerator.new(unique_number_sequence, number_encoder)
  end

  def self.bad_words_blacklist
    @bad_words_blacklist ||= BadWordsBlacklist.new %w[ foo bar ]
  end

  def self.unique_number_sequence
    GloballyUniqueNumber
  end

  def self.number_encoder
    NumberEncoder
  end
end
