# Brower

Welcome to Brower, the minimal Ruby re-implmentation of Bower that helps you to declare and retrieve your js dependencies without the need for a js runtime.

Inspired by https://github.com/zenhack/microbower (Python)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brower', :git => 'https://github.com/efi/brower'
```

And then execute:

    $ bundle

## Usage

get your bower.json in place (and optionally a .bowerrc) then call

```ruby
Brower.install
```