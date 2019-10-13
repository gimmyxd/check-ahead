# frozen_string_literal: true

require 'check-ahead/commits_checker'

namespace :'check-ahead' do
  desc 'verify that commit messages match CONTRIBUTING.md requirements'
  task :check_commits do
    range = ENV['TRAVIS_COMMIT_RANGE'].nil? ? 'master..HEAD' : ENV['TRAVIS_COMMIT_RANGE'].sub(/\.\.\./, '..')
    CheckAhead::CommitsChecker.new(range).call
  end

  desc 'generate the commits requirements to be added in CONTRIBUTING.md'
  task :generate_requirements do
  end
end
