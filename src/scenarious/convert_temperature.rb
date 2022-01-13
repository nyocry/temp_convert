# frozen_string_literal: true

require_relative 'exit'
require_relative '../io_adapter'
require_relative '../temperature/temperature_handler'
require_relative 'base_state'

module States
  class ConvertTemperature < Base
    attr_reader :type_of_degrees, :temperature_amount, :to_type

    def initialize(type_of_degrees, temperature_amount, to_type)
      super()
      @type_of_degrees = type_of_degrees
      @temperature_amount = temperature_amount
      @to_type = to_type
      @final_state = false
    end

    def next
      temperature_inf = TemperatureHandler.instance.inflate_class(type_of_degrees, temperature_amount.to_f)
      converted_temperature = TemperatureHandler.instance.convert(temperature_inf, to_type)
      IOAdapter.instance.write converted_temperature.value
      Exit.new
    end
  end
end
