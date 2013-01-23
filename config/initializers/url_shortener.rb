require 'url_shortener'
require 'number_encoder'

URL_SHORTENER = UrlShortener.new(ShortPathCandidateGenerator.new(GloballyUniqueNumber, NumberEncoder), BadWordsBlacklist.new(%w[ foo bar ]));
