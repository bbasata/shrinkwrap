require "spec_helper"
require "rspec/given"
require "rack/test"

describe "Shrinking URLs" do
  include Rack::Test::Methods

  def app
  	Shrinkwrap::Application
  end
  
  def shrink(url) 
	  post "http://shrinkwrap.herokuapp.com", :url => url
    last_response.body
  end

  Given(:long_url) { "https://github.com/bbasata/shrinkwrap/tree/walking-skeleton" }
  When(:short_url) { shrink(long_url) }
  Then { short_url.should == "http://shrinkwrap.herokuapp.com/shorturl" }
end