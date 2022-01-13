# frozen_string_literal: true

require 'singleton'

class TemperatureHandler
  include Singleton

  def correct_temperature_type?(degrees_type)
    return false unless degrees_type[/^[FfKkCc]$/]

    true
  end

  def inflate_class(type, temperature)
    if type[/^[Cc]$/]
      Temperature::Celsius.new(temperature)
    elsif type[/^[Kk]$/]
      Temperature::Kelvin.new(temperature)
    elsif type[/^[Ff]$/]
      Temperature::Fahrenheit.new(temperature)
    end
  end

  def convert(from, to)
    if to[/^[Cc]$/]
      from.to_celsius
    elsif to[/^[Kk]$/]
      from.to_kelvin
    elsif to[/^[Ff]$/]
      from.to_fahrenheit
    end
  end
end
