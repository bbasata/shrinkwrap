 module UrlShortener
   def self.shorten(long_url)
   	 url_mapping = UrlMapping.create!(
   	   :long_url => long_url,
   	   :short_path => "shorturl"
   	 )

   	 "http://shrinkwrap.herokuapp.com/#{url_mapping.short_path}"
   end
 end