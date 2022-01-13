# frozen_string_literal: true

require_relative 'base_state'

module States
  class Exit < Base
    attr_reader :type_of_degrees

    def initialize
      super()
      @final_state = true
    end

    def next
      self
    end
  end
end
