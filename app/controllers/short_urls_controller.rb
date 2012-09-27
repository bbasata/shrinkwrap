require 'url_shortener'
require 'url_expander'

class ShortUrlsController < ApplicationController
 
  def create
  	render :text => UrlShortener.shorten(params[:url])
  end

  def show
  	render :text => UrlMapping.find_by_short_path(params[:short_path]).long_url
  end
end
