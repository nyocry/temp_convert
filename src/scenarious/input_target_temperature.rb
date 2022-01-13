# frozen_string_literal: true

require_relative '../io_adapter'
require_relative '../temperature/temperature_handler'
require_relative 'convert_temperature'
require_relative 'base_state'

module States
  class InputTargetTemperature < Base
    attr_reader :type_of_degrees, :temperature_amount

    def initialize(type_of_degrees, temperature_amount)
      super()
      @type_of_degrees = type_of_degrees
      @temperature_amount = temperature_amount
      @final_state = false
    end

    def render
      IOAdapter.instance.write 'Convert to (F, C, K): '
    end

    def next
      to_type = IOAdapter.instance.read
      if TemperatureHandler.instance.correct_temperature_type?(to_type)
        ConvertTemperature.new(type_of_degrees, temperature_amount, to_type)
      else
        IOAdapter.instance.write 'Incorrect input'
        self
      end
    end
  end
end
