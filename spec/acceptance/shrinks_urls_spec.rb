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
    Then { short_url.should == "http://shrinkwrap.herokuapp.com/shorturl" }
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
    pending "produces the same short URL"
  end
end