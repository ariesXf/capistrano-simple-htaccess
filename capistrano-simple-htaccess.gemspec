# frozen_string_literal: true

require_relative 'lib/capistrano/simple_htaccess/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-simple-htaccess'
  spec.version       = Capistrano::SimpleHtaccess::VERSION
  spec.authors       = ['DaMoo']
  spec.email         = ['git@damoo.zone']

  spec.summary       = 'Capistrano task for including a simple apache .htaccess file for redirects on deploy'
  spec.homepage      = 'https://github.com/da-moo/capistrano-simple-htaccess'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/da-moo/capistrano-simple-htaccess'
  spec.metadata['changelog_uri'] = 'https://github.com/da-moo/capistrano-simple-htaccess/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.14'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rubocop', '>= 1.2'
end
