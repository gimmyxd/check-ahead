# frozen_string_literal: true

require 'punishas/version'
require 'punishas/commits_checker'

module Punishas
  def self.load_tasks
    Dir["#{root}/lib/tasks/**/*.rake"].each { |file| load file }
  end

  def self.root
    File.dirname(__dir__)
  end
end
