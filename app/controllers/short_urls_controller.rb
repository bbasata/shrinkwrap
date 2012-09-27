require 'url_shortener'

class ShortUrlsController < ApplicationController
 
  def create
  	url_mapping = UrlMapping.find_or_create(UrlShortener.shorten(params[:url]))
   	render :text => url(url_mapping.short_path)
  end

  def show
  	render :text => UrlMapping.find_by_short_path(params[:short_path]).long_url
  end

  private

  def url(short_path)
    "http://shrinkwrap.herokuapp.com/#{short_path}"
  end
end
