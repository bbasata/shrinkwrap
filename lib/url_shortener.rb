require 'bad_words_denylist'
require 'number_encoder'
require 'short_path_candidate_generator'

class UrlShortener
  def initialize(short_path_candidate_generator, bad_words_denylist)
    @short_path_candidate_generator = short_path_candidate_generator
    @bad_words_denylist = bad_words_denylist
  end

  def shorten(long_url)
    short_path = short_path_candidate_generator.find { |short_path| bad_words_denylist.accept?(short_path) }
    { :long_url => long_url, :short_path => short_path }
  end

  private
  attr_reader :short_path_candidate_generator, :bad_words_denylist
end
