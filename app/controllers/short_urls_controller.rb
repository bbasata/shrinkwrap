require 'url_shortener'

class ShortUrlsController < ApplicationController
 
  def create
  	render :text => UrlShortener.shorten(params[:url])
  end

  def show
  	render :text => ""
  end
end
