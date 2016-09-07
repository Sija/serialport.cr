# serialport.cr [![Build Status](https://travis-ci.org/Sija/serialport.cr.svg?branch=master)](https://travis-ci.org/Sija/serialport.cr)

Crystal bindings for [libserialport](http://sigrok.org/wiki/Libserialport): cross-platform library for accessing serial ports.

## Installation

### Prerequisites

  * Crystal >= 0.18.7
  * libserialport >= 0.1.1

To install the latest libserialport, you can use `homebrew` or `apt-get`, depending on the platform:

#### Mac OS X

```
$ brew tap rene-dev/sigrok
$ brew install --HEAD libserialport
```

#### Debian/Ubuntu

```
$ apt-get install libserialport
```

### Shard

Add this to your application's `shard.yml`:

```yaml
dependencies:
  serialport:
    github: sija/serialport.cr
```

## Usage


```crystal
require "serialport"
```


TODO: Write usage instructions here

## Development

```
crystal spec
```

## Contributing

1. Fork it ( https://github.com/sija/serialport.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@Sija](https://github.com/Sija) Sijawusz Pur Rahnama - creator, maintainer
