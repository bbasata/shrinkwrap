require 'url_shortener'
require 'url_expander'

class ShortUrlsController < ApplicationController
 
  def create
  	render :text => UrlShortener.shorten(params[:url])
  end

  def show
  	render :text => UrlExpander.expand(params[:id])
  end
end
