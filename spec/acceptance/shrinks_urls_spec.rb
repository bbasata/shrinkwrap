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
	last_request.body.read   
  end

  Given(:url) { "https://github.com/bbasata/shrinkwrap/tree/walking-skeleton" }
  When(:result) { shrink(url) }
  Then { result =~ "http://shrinkwrap.herokuapp.com/shorturl" }
end