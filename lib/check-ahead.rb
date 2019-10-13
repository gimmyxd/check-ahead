# frozen_string_literal: true

require 'check-ahead/version'
require 'check-ahead/configuration'
require 'check-ahead/commits_checker'

module CheckAhead
  class << self
    def load_tasks
      Dir["#{File.dirname(__dir__)}/lib/tasks/**/*.rake"].each { |file| load file }
    end
  end
end
