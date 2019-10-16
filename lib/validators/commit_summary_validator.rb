# frozen_string_literal: true

class CommitSummaryValidator
  class << self
    def call(record)
      return if record.summary =~ rules

      record.errors[:summary] = error_message
    end

    private

    def rules
      /^\((#{ContributingMd.accepted_tags})\)|#{CheckAhead.configuration.base_tags.join('|')}/i
    end

    def error_message
      "\tThe commit summary (i.e. the first line of the commit message) must start with one of:\n\n"  \
      "#{ContributingMd.accepted_commits_section.delete('\\').split('*').join("\t\t")}\n" \
      "\t\t #{CheckAhead.configuration.base_tags.join("\n\t\t ")}\n" \
      "\n\tThis test for the commit summary is case-insensitive.\n"
    end
  end
end
