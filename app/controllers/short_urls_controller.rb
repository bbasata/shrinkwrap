class ShortUrlsController < ApplicationController
  def create
  	render :text => "http://shrinkwrap.herokuapp.com/shorturl"
  end
end
