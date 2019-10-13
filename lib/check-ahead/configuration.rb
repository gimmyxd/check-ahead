# frozen_string_literal: true

module CheckAhead
  class Configuration
    attr_accessor :base_tags, :contributing_md, :range

    def initialize
      @base_tags = %w[revert merge packaging]
      @contributing_md = File.join(Dir.pwd, 'CONTRIBUTING.md')
      @range = 'master..HEAD'
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
