# frozen_string_literal: true

module States
  class Base
    attr_reader :final_state

    def render; end

    def next; end
  end
end
