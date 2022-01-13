# frozen_string_literal: true

require_relative '../io_adapter'
require_relative '../temperature/temperature_handler'
require_relative 'input_target_temperature'
require_relative 'base_state'

module States
  class InputSourceTemperatureAmount < Base
    attr_reader :type_of_degrees

    def initialize(type_of_degrees)
      super()
      @type_of_degrees = type_of_degrees
      @final_state = false
    end

    def render
      IOAdapter.instance.write 'Enter temperature amount: '
    end

    def next
      temperature_amount = IOAdapter.instance.read
      is_number = number?(temperature_amount)

      if is_number
        InputTargetTemperature.new(type_of_degrees, temperature_amount)
      else
        IOAdapter.instance.write 'Incorrect number'
        self
      end
    end

    private

    def number?(number)
      return false unless number[/^-?[1-9][0-9]*\.?[0-9]*$/]

      true
    end
  end
end
