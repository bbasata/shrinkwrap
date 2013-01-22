require 'url_shortener'

describe UrlShortener do
  let(:bad_words_blacklist) { BadWordsBlacklist.new %w[ bad ] }
  let(:unique_number_sequence) { double.stub(:next).and_return(1, 2, 3) }

  before do
    UrlShortener.stub(:short_path_candidate_generator).and_return(short_path_candidate_generator)
    UrlShortener.stub(:bad_words_blacklist).and_return(bad_words_blacklist)
    UrlShortener.stub(:unique_number_sequence).and_return(unique_number_sequence)
  end

  context "when a candidate short path does not contain a bad word" do
    let(:short_path_candidate_generator) { [
      "i am good",
      "i am also good"
    ] }

    it "returns the next good candidate" do
      UrlShortener.shorten("http://example.com").fetch(:short_path).should == "i am good"
    end
  end
  context "when a candidate short path contains a bad word" do
    let(:short_path_candidate_generator) { [
      "i contain a bad word",
      "i also contain a bad word",
      "i am good"
    ] }

    it "returns the next good candidate" do
      UrlShortener.shorten("http://example.com").fetch(:short_path).should == "i am good"
    end
  end
end
