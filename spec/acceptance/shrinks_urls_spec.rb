require "spec_helper"
require "rspec/given"
require "rack/test"

describe "Shrinking URLs" do
  include Rack::Test::Methods

  def app
    Shrinkwrap::Application
  end

  def shrink(url)
    post "/", :url => url
    last_response.body
  end

  def unshrink(url)
    get url
    last_response.body
  end

  context "Shrinking a URL" do
    Given(:long_url) { "https://github.com/bbasata/shrinkwrap/tree/walking-skeleton" }
    When(:short_url) { shrink(long_url) }
    Then { expect(short_url).to match %r|http://shrinkwrap\.herokuapp\.com/[A-Z0-9]{1,7}| }
  end

  context "Unshrinking a URL" do
    Given(:long_url) { "https://github.com/bbasata/shrinkwrap/tree/walking-skeleton" }
    Given(:short_url) { shrink(long_url) }
    When(:unshrunk_url) { unshrink(short_url) }
    Then { expect(unshrunk_url).to eq long_url }
  end

  context "Shrinking multiple URLs" do
    Given(:short_urls) { [
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile"),
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Rakefile")
    ] }
    Then { expect(short_urls.uniq.size).to eq 2 }
  end

  context "Shrinking the same URL twice" do
    Given(:short_urls) { [
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile"),
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile")
    ] }
    Then { expect(short_urls.uniq.size).to eq 1 }
  end

  context "Correcting mistakes in transcription of 'I' as '1' and 'O' as '0'" do
    it "corrects mistakes" do
      url_mapping = UrlMapping.create!(:short_path => 'ORIGAMI', :long_url => 'http://origami.example.com')
      unshrunk_url = unshrink("/0R1GAM1")
      expect(unshrunk_url).to eq url_mapping.long_url
    end
  end
end
