# frozen_string_literal: true

require 'singleton'

class IOAdapter
  include Singleton

  def write(str)
    puts str
  end

  def read
    gets
  end

  def exit?(value)
    value[/^[Qq]$/]
  end
end
