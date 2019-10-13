# frozen_string_literal: true

module CheckAhead
  class Configuration
    attr_accessor :base_tags, :contributing_md, :commit_range

    def initialize
      @base_tags = ENV['BASE_TAGS'] || %w[revert merge packaging]
      @contributing_md = ENV['CONTRIBUTING_MD'] || File.join(Dir.pwd, 'CONTRIBUTING.md')
      @commit_range = (ENV['COMMIT_RANGE'] || 'master..HEAD').sub(/\.\.\./, '..')
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
