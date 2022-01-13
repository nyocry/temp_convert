# frozen_string_literal: true

require_relative '../src/temperature/temperature'

RSpec.describe Temperature::Celsius do
  subject(:value) { 1.0 }
  subject { described_class.new value }

  it 'when converting to celsius' do
    expect(subject.to_celsius.value).to eq(value)
  end

  it 'when converting to fahrenheit' do
    expect(subject.to_fahrenheit.value).to eq(33.8)
  end

  it 'when converting to to_kelvin' do
    expect(subject.to_kelvin.value).to eq(274.15)
  end
end
