# frozen_string_literal: true

module Punishas
  class CommitsChecker
    def initialize(range)
      @range = range
    end

    def call
      check_commits
    end

    private

    BASE_TAGS = ENV['BASE_TAGS'] || Punishas.configuration.base_tags

    def check_commits
      `git log --no-merges --pretty=%s #{@range}`.each_line do |commit_summary|
        raise error_message(commit_summary) unless commit_summary =~ rules

        puts commit_summary.to_s
      end
    end

    def rules
      /^\((#{accepted_tags})\)|#{BASE_TAGS.join('|')}/i
    end

    def error_message(commit_summary)
      "\n\n\n\tThis commit summary didn't match CONTRIBUTING.md guidelines:\n" \
      "\n\t\t#{commit_summary}\n" \
      "\tThe commit summary (i.e. the first line of the commit message) must start with one of:\n\n"  \
      "#{accepted_commits_section.delete('\\').split('*').join("\t\t")}\n" \
      "\t\t #{BASE_TAGS.join("\n\t\t ")}\n" \
      "\n\tThis test for the commit summary is case-insensitive.\n\n\n"
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
              'please run punishas:generate_requirements'
      end
    end

    def contributing_file
      @contributing_file ||= File.read(ENV['CONTRIBUTING_MD'] || "#{Dir.pwd}/CONTRIBUTING.md")
    end
  end
end
