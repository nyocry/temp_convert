# frozen_string_literal: true

class Temperature
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_kelvin; end

  def to_celsius; end

  def to_fahrenheit; end

  class Celsius < Temperature
    def to_kelvin
      Kelvin.new(@value + 273.15)
    end

    def to_celsius
      Celsius.new(@value)
    end

    def to_fahrenheit
      Fahrenheit.new((@value * 1.8) + 32.0)
    end
  end

  class Fahrenheit < Temperature
    def to_kelvin
      Kelvin.new(((@value - 32.0) * (5.0 / 9.0)) + 273.15)
    end

    def to_celsius
      Celsius.new((@value - 32.0) * (5.0 / 9.0))
    end

    def to_fahrenheit
      Fahrenheit.new(@value)
    end
  end

  class Kelvin < Temperature
    def to_kelvin
      Kelvin.new(@value)
    end

    def to_celsius
      Celsius.new(@value - 273.15)
    end

    def to_fahrenheit
      Fahrenheit.new(((@value - 273.15) * (9.0 / 5.0)) + 32.0)
    end
  end
end
