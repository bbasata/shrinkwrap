require 'url_shortener'

describe UrlShortener do
  let(:bad_words_blacklist) { BadWordsBlacklist.new %w[ bad ] }
  subject { UrlShortener.new(short_path_candidate_generator, bad_words_blacklist) }

  context "when a candidate short path does not contain a bad word" do
    let(:short_path_candidate_generator) { [
      "i am good",
      "i am also good"
    ] }

    it "returns the next good candidate" do
      expect(subject.shorten("http://example.com").fetch(:short_path)).to eq "i am good"
    end
  end

  context "when a candidate short path contains a bad word" do
    let(:short_path_candidate_generator) { [
      "i contain a bad word",
      "i also contain a bad word",
      "i am good"
    ] }

    it "returns the next good candidate" do
      expect(subject.shorten("http://example.com").fetch(:short_path)).to eq "i am good"
    end
  end
end
