class UrlMapping < ActiveRecord::Base
  attr_accessible :long_url, :short_path

  def self.find_or_create(url_mapping)
    find_or_create_by_long_url(url_mapping)
  end
end
