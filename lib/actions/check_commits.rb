# frozen_string_literal: true

require 'validators/commit_summary_validator'
require 'validators/commit_length_validator'

module Actions
  class CheckCommits
    def initialize
      @config = CheckAhead.configuration
    end

    def execute
      check_commits
    end

    private

    def check_commits
      git_log.each_line do |commit_summary|
        commit = Commit.new(commit_summary)
        CommitSummaryValidator.call(commit) if @config.check_commit_message?
        CommitLengthValidator.call(commit) if @config.check_max_length?
        error_message = commit.errors.values.join

        if error_message.empty?
          STDOUT.puts "PASSED: #{commit_summary}"
        else
          error_message = error_message_header(commit_summary) + error_message
          warn error_message
          exit(false)
        end
      end
    end

    def git_log
      `git log --no-merges --pretty=%s #{@config.commit_range}`
    end

    def error_message_header(commit_summary)
      "\n\tCommit summary: #{commit_summary}\n".bold
    end
  end
end
