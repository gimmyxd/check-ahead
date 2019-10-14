# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'check-ahead/version'

Gem::Specification.new do |spec|
  spec.name          = 'check-ahead'
  spec.version       = CheckAhead::VERSION
  spec.authors       = ['gimmy']
  spec.email         = ['gheorghe.popescu@puppet.com']

  spec.summary       = 'Guard against unwanted commits'
  spec.description   = 'CheckAhead let you define rules to guard against unwanted commits'
  spec.homepage      = 'https://github.com/gimmyxd/check-ahead'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gimmyxd/check-ahead'
  spec.metadata['changelog_uri'] = 'https://github.com/gimmyxd/check-ahead/blob/master/CHANGELONG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end