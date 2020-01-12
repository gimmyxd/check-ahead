# frozen_string_literal: true

require 'dry/cli'
require 'cli/commands'

module CheckAhead
  module CLI
    class Application < Dry::CLI
      def self.start
        new.call
      end

      def self.new(commands = CLI::Commands)
        super
      end
    end
  end
end
