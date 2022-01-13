# frozen_string_literal: true

require_relative '../src/temperature/temperature'

RSpec.describe Temperature::Kelvin do
  subject(:value) { 274.15 }
  subject { described_class.new value }

  it 'when converting to celsius' do
    expect(subject.to_celsius.value).to eq(1.0)
  end

  it 'when converting to fahrenheit' do
    expect(subject.to_fahrenheit.value).to eq(33.8)
  end

  it 'when converting to to_kelvin' do
    expect(subject.to_kelvin.value).to eq(value)
  end
end
