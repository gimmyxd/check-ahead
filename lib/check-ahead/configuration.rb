# frozen_string_literal: true

module CheckAhead
  class Configuration
    DEFAULT_ATTRS = {
      base_tags: %w[revert merge],
      contributing_md: File.join(Dir.pwd, 'CONTRIBUTING.md'),
      commit_range: 'HEAD~1..HEAD',
      max_length: 50,
      check_max_length: false,
      check_commit_message: true
    }.freeze

    ATTRS = DEFAULT_ATTRS.keys

    attr_accessor(*ATTRS)

    def initialize
      DEFAULT_ATTRS.each do |attribute, value|
        send("#{attribute}=", ENV[attribute.to_s.upcase] || value)
      end
    end

    ATTRS.select { |attribute| attribute.to_s.start_with?('check') }.each do |attribute|
      define_method("#{attribute}?") do
        ['true', true].include?(send(attribute))
      end
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
