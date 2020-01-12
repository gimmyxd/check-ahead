# frozen_string_literal: true

describe Actions::CheckCommits do
  subject(:check_commits) { described_class.new.execute }

  let(:commit_messages) { "commit1\ncommit2" }

  before do
    allow(described_class).to receive(:`).and_return(commit_messages)
  end

  context 'when CONTRIBUTING.md is not found' do
    it do
      expect { check_commits.execute }.to \
        raise_error(IOError, /CONTRIBUTING.md not found/)
    end
  end
end
