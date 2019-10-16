# frozen_string_literal: true

class CommitLengthValidator
  class << self
    def call(record)
      return if record.summary.length < CheckAhead.configuration.max_length

      record.errors[:length] = error_message(record.summary.length)
    end

    private

    def error_message(length)
      "\n\tThis commit summary is too long: #{length}/#{CheckAhead.configuration.max_length}\n\n"
    end
  end
end
