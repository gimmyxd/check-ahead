# frozen_string_literal: true

class Commit
  attr_accessor :summary, :errors

  def initialize(summary, errors = {})
    @summary = summary
    @errors = errors
  end
end
