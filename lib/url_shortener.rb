 module UrlShortener
   def self.shorten(long_url)
   	 unique_number = GloballyUniqueNumber.next
   	 short_path = NumberEncoder.encode(unique_number)
   	 { :long_url => long_url, :short_path => short_path }
   end
 end