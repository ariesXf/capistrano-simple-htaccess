# Capistrano::SimpleHtaccess

[![Gem Version](https://badge.fury.io/rb/capistrano-simple-htaccess.svg)](https://badge.fury.io/rb/capistrano-simple-htaccess)

Capistrano task for including a simple apache .htaccess file for redirects on deploy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-simple-htaccess'
```

Then add it to your `Capfile`:

```ruby
require 'capistrano/simple_htaccess'
```

And then:

```sh
$ bundle install
```

## How it works

This gem hooks into Capistrano's flow by executing an `upload` task after the `deploy:updated` portion of Capistrano's
[flow](https://capistranorb.com/documentation/getting-started/flow/). See the source for more details

## The default .htaccess file

Found as a HEREDOC string in `lib/capistrano/tasks/simple_htaccess.rake`, but also here for your convenience:

```apache
<IfModule mod_rewrite.c>
  Options +FollowSymLinks

  RewriteEngine On
  RewriteCond %{REQUEST_URI} !/current/
  RewriteRule ^(.*)$ current/$1 [L]
</IfModule>
```

## Configuration

If you want a different .htaccess uploaded, just change the `:HTACCESS` variable as part of your deploy config. Ex:

```ruby
set(:HTACCESS), <<HTACCESS
# Put your .htaccess config here
HTACCESS
```

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
