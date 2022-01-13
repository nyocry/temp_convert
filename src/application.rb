# frozen_string_literal: true

require_relative 'temperature/temperature'
require_relative 'io_adapter'
require_relative 'temperature/temperature_handler'
require_relative 'scenarious/input_source_tempreture'

class Application
  def run
    @state = States::InputSourceTemperature.new
    while @state.final_state == false
      @state.render
      @state = @state.next
    end
  end
end
