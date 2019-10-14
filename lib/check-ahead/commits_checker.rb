# frozen_string_literal: true

module CheckAhead
  class CommitsChecker
    def initialize
      @config = CheckAhead.configuration
      @commit_range = @config.commit_range
      @base_tags = @config.base_tags
      @max_length = @config.max_length
      @error_message = ''
    end

    def call
      check_commits
    end

    private

    def check_commits
      `git log --no-merges --pretty=%s #{@commit_range}`.each_line do |commit_summary|
        check_max_length(commit_summary) if @config.check_max_length
        @error_message += summary_error_message unless commit_summary =~ rules

        if @error_message.empty?
          STDOUT.puts "PASSED: #{commit_summary}"
        else
          @error_message = error_message_header(commit_summary) + @error_message
          raise @error_message
        end
      end
    end

    def check_max_length(commit_summary)
      length = commit_summary.length
      @error_message += length_error_message(length) if length > @max_length
    end

    def rules
      /^\((#{accepted_tags})\)|#{@base_tags.join('|')}/i
    end

    def summary_error_message
      "\tThe commit summary (i.e. the first line of the commit message) must start with one of:\n\n"  \
      "#{accepted_commits_section.delete('\\').split('*').join("\t\t")}\n" \
      "\t\t #{@base_tags.join("\n\t\t ")}\n" \
      "\n\tThis test for the commit summary is case-insensitive.\n\n\n"
    end

    def length_error_message(length)
      "\n\tThis commit summary is too long: #{length}/#{@max_length}\n\n"
    end

    def error_message_header(commit_summary)
      "\n\tCommit summary: #{commit_summary}".bold
    end

    def accepted_tags
      @accepted_tags ||= accepted_commits_section
                         .delete("\n*")
                         .gsub("\<digits>", 'd+')
                         .split
                         .join('|')
    end

    def accepted_commits_section
      @accepted_commits_section ||= contributing_file.match(%r{<commits>(.*)</commits>}m)
      if @accepted_commits_section
        @accepted_commits_section[1].chomp.strip
      else
        raise 'information not foud in CONTRIBUTING.md, ' \
              'please run check-ahead:generate_requirements'
      end
    end

    def contributing_file
      @contributing_file ||= File.read(@config.contributing_md)
    end
  end
end
