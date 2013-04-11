require 'url_shortener'

class ShortUrlsController < ApplicationController

  def create
    params.require(:url)
    url_mapping_value = URL_SHORTENER.shorten(params[:url])
    url_mapping = UrlMapping.find_or_create(url_mapping_value)
    render :text => url(url_mapping.short_path)
  end

  def show
    params.require(:short_path)
    normalized_short_path = NumberEncoder.normalize(params[:short_path])
    render :text => UrlMapping.find_by_short_path(normalized_short_path).long_url
  end

  private

  def url(short_path)
    "http://shrinkwrap.herokuapp.com/#{short_path}"
  end
end
