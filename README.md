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
# Works in the terminal

The gem contains two executables: tlf and gulesider. They can both be used from within the terminal, 
after the gem is installed.

```
tlf 98260555
```
or

```
gulesider 98260555
```

This wil output

```
Søker på gulesider.no

Stian Eliassen
Sentrum 4, 9700 Lakselv
```

Enjoy!:)