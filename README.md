# Gulesider
A ruby gem that does screen scraping of gulesider.no, a global norwegian phone book.

# Installation

```

[sudo] gem install gulesider

```

# Usage

```

result = Gulesider.search 99999999
puts result[:name]

```