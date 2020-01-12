# frozen_string_literal: true

require 'bundler/setup'
require 'dry/cli'
require 'actions/check_commits'
require 'actions/generate_rules'

module CheckAhead
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class CheckCommits < Dry::CLI::Command
        desc 'verify that commit messages match CONTRIBUTING.md requirements'

        def call(*)
          Actions::CheckCommits.new.execute
        end
      end

      class GenerateRules < Dry::CLI::Command
        desc 'generate the commits requirements to be added in CONTRIBUTING.md'
        argument :tags,
                 required: true,
                 desc: 'tags separated by ",", used to generate rules, Example: PA-<digits>,maint,bump'

        def call(tags:, **)
          STDOUT.puts("\n\nGenerated output - please add it to CONTRIBUTING.md \n\n")
          STDOUT.puts Actions::GenerateRules.new(tags).execute
        end
      end

      register 'check_commits', CheckCommits
      register 'generate_rules', GenerateRules
    end
  end
end
