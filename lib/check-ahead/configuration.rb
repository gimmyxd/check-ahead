# frozen_string_literal: true

module CheckAhead
  class Configuration
    attr_accessor :base_tags, :contributing_md, :commit_range,
                  :max_length, :check_max_length

    def initialize
      @base_tags = ENV['BASE_TAGS'] || %w[revert merge]
      @contributing_md = ENV['CONTRIBUTING_MD'] || File.join(Dir.pwd, 'CONTRIBUTING.md')
      @commit_range = ENV['COMMIT_RANGE'].to_s.sub(/\.\.\./, '..')
      @max_length = ENV['MAX_LENGTH'] || 50
      @check_max_length = ENV['CHECK_MAX_LENGTH'] || false
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
