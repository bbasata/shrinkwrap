After reviewing the codebase, here are my recommendations for refactoring toward more idiomatic Ruby 3.0 usage:

1. Use Ruby 3.0 Pattern Matching:
```ruby
# In ShortUrlsController
def show
  case params 
  in { short_path: short_path }
    normalized_path = NumberEncoder.normalize(short_path)
    render plain: UrlMapping.find_by_short_path(normalized_path).long_url
  else
    head :bad_request
  end
end
```

2. Use Ruby 3.0 Endless Methods for simple methods:
```ruby
# In ApplicationHelper
module ApplicationHelper
  def page_title = "URL Shortener"
end
```

3. Use Ruby 3.0 Hash#except and Hash#transform_keys:
```ruby
# In UrlMapping
def self.find_or_create(url_mapping)
  sanitized_params = url_mapping.transform_keys(&:to_sym)
  where(long_url: sanitized_params[:long_url]).first_or_create(sanitized_params)
end
```

4. Use Keyword Arguments consistently:
```ruby
# In UrlShortener
def initialize(generator:, denylist:)
  @short_path_candidate_generator = generator
  @bad_words_denylist = denylist
end
```

5. Use Ruby 3.0 Numbered Parameters for simple blocks:
```ruby
# In NumberEncoder
def self.encode(number)
  number = number * (ALPHABET.length + 1)
  Radix::Integer.new(_1).to_s(ALPHABET)
end
```

6. Use Ruby 3.0 RBS Type Signatures:
Add type definitions in separate .rbs files:
```ruby
# sig/url_shortener.rbs
class UrlShortener
  def initialize: (generator: ShortPathCandidateGenerator, denylist: BadWordsDenylist) -> void
  def shorten: (String) -> Hash[Symbol, String]
end
```

7. Use Zeitwerk for autoloading:
Update application.rb:
```ruby
config.autoloader = :zeitwerk
```

8. Use Active Record Attributes API:
```ruby
# In UrlMapping
class UrlMapping < ApplicationRecord
  attribute :long_url, :string
  attribute :short_path, :string
  
  validates :long_url, presence: true, format: URI::regexp(%w[http https])
end
```

9. Use Modern RSpec Syntax:
```ruby
# In specs
RSpec.describe UrlShortener do
  subject { described_class.new(generator:, denylist:) }
  
  let(:generator) { instance_double(ShortPathCandidateGenerator) }
  let(:denylist) { instance_double(BadWordsDenylist) }
  
  it { is_expected.to respond_to(:shorten) }
end
```

10. Use Safer Database Transactions:
```ruby
# In GloballyUniqueNumber
def self.next
  transaction(isolation: :serializable) do
    number = first || seed
    number.increment!(:last_value)
    number.last_value
  end
end
```

11. Update Configuration for Modern Rails:
```ruby
# config/application.rb
config.load_defaults 6.1
config.active_record.schema_format = :sql
config.active_record.verify_foreign_keys_for_fixtures = true
```

12. Use Exception Class Inheritance:
```ruby
# Add custom exceptions
module UrlShortener
  class Error < StandardError; end
  class ValidationError < Error; end
  class DenylistError < Error; end
end
```

13. Use Structured Logging:
```ruby
# In ShortUrlsController
def create
  Rails.logger.info(
    action: "shorten_url",
    original_url: params[:url],
    user_agent: request.user_agent
  )
  # ... rest of the code
end
```

14. Use Ruby 3.0 Ractor for Parallel Processing (if needed):
```ruby
# For batch processing URLs
def batch_shorten(urls)
  urls.map do |url|
    Ractor.new(url) do |long_url|
      URL_SHORTENER.shorten(long_url)
    end
  end.map(&:take)
end
```

These refactoring suggestions would make the code more idiomatic for Ruby 3.0 while maintaining functionality. They introduce:

- Modern Ruby syntax features
- Better type safety
- Improved performance
- Better error handling
- More maintainable code structure
- Better logging and monitoring capabilities

Would you like me to elaborate on any of these suggestions or provide more specific examples for certain parts of the codebase?
