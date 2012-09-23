module UrlExpander
  def self.expand(short_path)
    UrlMapping.find_by_short_path(short_path).long_url
  end
end