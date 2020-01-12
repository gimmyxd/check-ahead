# frozen_string_literal: true

module Actions
  class GenerateRules
    def initialize(input)
      @input = input
    end

    def execute
      generate_output.green
    end

    private

    def generate_output
      "#{header}" \
      "<commits>\n\n" \
        "#{split_input}\n" \
        "</commits>\n"
    end

    def split_input
      @input.gsub('<digits>', '\\<digits>')
            .split(',').map { |node| "* #{node}" }.join("\n")
    end

    def header
      "### Commit Message\n" \
      "Accepted commits messages:\n"
    end
  end
end
