class UrlMapping < ActiveRecord::Base
  def self.find_or_create(url_mapping)
    where(long_url: url_mapping[:long_url]).first_or_create(url_mapping)
  end
end
