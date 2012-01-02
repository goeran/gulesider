# Gulesider
A ruby gem that screen scrapes gulesider.no, a global norwegian phone book. This gem makes it easy to lookup norwegian phone numbers.

# Installation

```

[sudo] gem install gulesider

```

You can find the ruby gem here: https://rubygems.org/gems/gulesider

# Usage

```

result = Gulesider.search 99999999
puts result[:name]

```