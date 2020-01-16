# frozen_string_literal: true

require 'core_extensions/string'
require 'check-ahead/version'
require 'check-ahead/configuration'
require 'data/commit'
require 'data/contributing_md'

module CheckAhead
  class << self
    def load_tasks
      Dir["#{File.dirname(__dir__)}/lib/tasks/**/*.rake"].each { |file| load file }
    end

    def included(_base)
      load_tasks
    end
  end
end
