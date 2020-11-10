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
  RewriteBase "%<base>s"
  RewriteRule ^current(.*) %<base>s$1 [NC,R,END]
  RewriteRule ^((?!current/).*)$ current/$1 [NC,END]
</IfModule>
```

The `%<base>s` template strings are replaced with the value of your `:deploy_to` directory, with the `:document_root` variable removed from the string's prefix. This creates a base directory string.

Ex: 

```ruby
set :deploy_to, '/var/www/html/example1/public'
set :document_root, '/var/www/html'

# %<base>s would then be replaced with: /example1/public
```

## Configuration

If you want a different .htaccess uploaded, just change the `:HTACCESS` variable as part of your deploy config. Ex:

```ruby
set :HTACCESS, <<HTACCESS
# Put your .htaccess config here
HTACCESS
```

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
