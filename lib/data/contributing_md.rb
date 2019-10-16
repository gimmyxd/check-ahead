# frozen_string_literal: true

class ContributingMd
  class << self
    def accepted_tags
      @accepted_tags ||= accepted_commits_section
                         .delete("\n*")
                         .gsub("\<digits>", 'd+')
                         .split
                         .join('|')
    end

    def accepted_commits_section
      accepted_commits_section ||= contributing_file.match(%r{<commits>(.*)</commits>}m)
      if accepted_commits_section
        accepted_commits_section[1].chomp.strip
      else
        raise 'information not foud in CONTRIBUTING.md, ' \
              'please run check-ahead:generate_requirements'
      end
    end

    private

    def contributing_file
      @contributing_file ||= File.read(CheckAhead.configuration.contributing_md)
    end
  end
end
