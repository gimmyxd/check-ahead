# frozen_string_literal: true

require 'check-ahead/commits_checker'

namespace :'check-ahead' do
  desc 'verify that commit messages match CONTRIBUTING.md requirements'
  task :commits do
    CheckAhead::CommitsChecker.new.call
  end

  desc 'generate the commits requirements to be added in CONTRIBUTING.md'
  task :generate_requirements do
  end
end
