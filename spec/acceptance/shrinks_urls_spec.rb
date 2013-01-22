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
    Then { short_url.should =~ %r|http://shrinkwrap\.herokuapp\.com/[A-Z0-9]{1,7}| }
  end

  context "Unshrinking a URL" do
    Given(:long_url) { "https://github.com/bbasata/shrinkwrap/tree/walking-skeleton" }
    Given(:short_url) { shrink(long_url) }
    When(:unshrunk_url) { unshrink(short_url) }
    Then { unshrunk_url.should == long_url }
  end

  context "Shrinking multiple URLs" do
    Given(:short_urls) { [
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile"),
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Rakefile")
    ] }
    Then { short_urls.uniq.should have(2).distinct_urls }
  end

  context "Shrinking the same URL twice" do
    Given(:short_urls) { [
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile"),
      shrink("https://github.com/bbasata/shrinkwrap/blob/master/Gemfile")
    ] }
    Then { short_urls.uniq.should have(1).distinct_urls }
  end

  context "Correcting mistakes in transcription of 'I' as '1' and 'O' as '0'" do
    it "corrects mistakes" do
      url_mapping = UrlMapping.create!(:short_path => 'ORIGAMI', :long_url => 'http://origami.example.com')
      unshrunk_url = unshrink("/0R1GAM1")
      unshrunk_url.should == url_mapping.long_url
    end
  end
end
