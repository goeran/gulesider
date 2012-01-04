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
# Bash Script

The bash script is called tlf, which can be installed using the terminal. Open the terminal and start typing

```
sudo cp tlf /usr/bin/tlf
sudo chmod 755 /usr/bin/tlf

```

The last statement sets execution permission on the bash script. You can now lookup numbers in the terminal

```
tlf 98260555
````

Enjoy!:)