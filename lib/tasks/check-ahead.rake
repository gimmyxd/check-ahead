# frozen_string_literal: true

require 'actions/check_commits'
require 'actions/generate_rules'

namespace :'check-ahead' do
  desc 'verify that commit messages match CONTRIBUTING.md requirements'
  task :commits do
    Actions::CheckCommits.new.execute
  end

  desc 'generate the commits requirements to be added in CONTRIBUTING.md'
  task :generate_rules do
    STDOUT.puts("Enter the tags separated by \",\" \nExample: PA-<digits>,maint,bump")

    input = STDIN.gets.strip

    abort('Bad input'.bold.red) if input.empty?

    STDOUT.puts("\n\nGenerated output - please add it to CONTRIBUTING.md \n\n")
    STDOUT.puts Actions::GenerateRules.new(input).execute
  end
end
