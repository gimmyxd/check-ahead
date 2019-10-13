# frozen_string_literal: true

require 'punishas/version'
require 'punishas/configuration'
require 'punishas/commits_checker'

module Punishas
  class << self
    def load_tasks
      Dir["#{File.dirname(__dir__)}/lib/tasks/**/*.rake"].each { |file| load file }
    end
  end
end
