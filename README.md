Here's a generated README.md file for the code repository:

# Shrinkwrap - URL Shortener

[![Build Status](https://travis-ci.org/bbasata/shrinkwrap.png?branch=master)](https://travis-ci.org/bbasata/shrinkwrap)
[![Code Climate](https://codeclimate.com/github/bbasata/shrinkwrap.png)](https://codeclimate.com/github/bbasata/shrinkwrap)

Shrinkwrap is a URL shortening service built with Ruby on Rails that creates short, memorable URLs that redirect to longer ones.

## Features

- Generates short URLs using a unique encoding algorithm
- Maintains a 1:1 mapping between short and long URLs
- Avoids generating offensive words in short URLs using a denylist
- Handles common transcription errors (0->O, 1->I)
- Creates URLs that differ by at least 2 characters to avoid typos
- Provides a simple REST API for shortening and expanding URLs

## API Usage

### Shorten a URL

```bash
POST /
Content-Type: application/x-www-form-urlencoded

url=https://your-long-url.com
```

Returns: Short URL (e.g. `http://shrinkwrap.herokuapp.com/ABC123`)

### Expand a URL 

```bash
GET /{short_path}
```

Returns: Original long URL

## Technical Details

- Built with Ruby on Rails 6.0
- Uses PostgreSQL for persistent storage
- Implements a custom base-n number encoding scheme
- Generates sparse URL codes to prevent similar-looking URLs
- Uses transaction-safe unique number generation

## Development Setup

1. Install dependencies:
```bash
bundle install
```

2. Setup database:
```bash
rake db:create db:migrate
```

3. Run tests:
```bash
bundle exec rake spec
```

4. Start server:
```bash
rails server
```

## Requirements

- Ruby 3.0.0
- PostgreSQL

## Testing

The application includes:
- RSpec unit tests
- Integration tests
- Acceptance tests using Cucumber

Run the full test suite with:
```bash 
bundle exec rake
```

## Deployment

The application is configured for deployment on Heroku.

## License

[License information not specified in original codebase]

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Credits

Created by bbasata
