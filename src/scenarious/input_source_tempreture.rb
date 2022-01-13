# frozen_string_literal: true

require_relative 'input_source_temperature_amount'
require_relative 'exit'
require_relative '../io_adapter'
require_relative '../temperature/temperature_handler'
require_relative 'base_state'

module States
  class InputSourceTemperature < Base
    def initialize
      super()
      @final_state = false
    end

    def render
      IOAdapter.instance.write 'Enter type of degrees (F,C,K), Q for exit: '
    end

    def next
      type_of_degrees = IOAdapter.instance.read
      is_correct_type = TemperatureHandler.instance.correct_temperature_type?(type_of_degrees)

      if is_correct_type
        InputSourceTemperatureAmount.new(type_of_degrees)
      elsif IOAdapter.instance.exit?(type_of_degrees)
        Exit.new
      else
        IOAdapter.instance.write 'Incorrect type'
        self
      end
    end
  end
end
