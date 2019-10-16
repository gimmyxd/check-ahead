# frozen_string_literal: true

require 'actions/commits_checker'
require 'actions/contributing_generator'

namespace :'check-ahead' do
  desc 'verify that commit messages match CONTRIBUTING.md requirements'
  task :commits do
    Actions::CommitsChecker.new.call
  end

  desc 'generate the commits requirements to be added in CONTRIBUTING.md'
  task :generate_requirements do
    STDOUT.puts("Enter the tags separated by \",\" \nExample: PA-<digits>,maint,bump")

    input = STDIN.gets.strip

    abort('Bad input'.bold.red) if input.empty?

    STDOUT.puts("\n\nGenerated output - please add it to CONTRIBUTING.md \n\n")
    STDOUT.puts Actions::ContributingGenerator.new(input).call
  end
end
