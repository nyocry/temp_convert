# frozen_string_literal: true

require_relative '../src/temperature/temperature_handler'
require_relative '../src/io_adapter'

RSpec.describe TemperatureHandler do
  subject { TemperatureHandler.instance }
  let(:io_adapter_mock) { instance_double IOAdapter }
  temperature = 1.0

  describe '#correct_temperature_type?' do
    it 'when the user inputs "F"' do
      
      allow(io_adapter_mock).to receive(:read).and_return('f')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
      allow(io_adapter_mock).to receive(:read).and_return('F')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
    end

    it 'when the user inputs "K"' do
      allow(io_adapter_mock).to receive(:read).and_return('k')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
      allow(io_adapter_mock).to receive(:read).and_return('K')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
    end

    it 'when the user inputs "C"' do
      allow(io_adapter_mock).to receive(:read).and_return('c')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
      allow(io_adapter_mock).to receive(:read).and_return('C')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(true)
    end

    it 'when the user inputs another value' do
      allow(io_adapter_mock).to receive(:read).and_return('5')
      expect(subject.correct_temperature_type?(io_adapter_mock.read)).to eq(false)
    end
  end

  describe '#inflate_class' do
    it 'when inflates Celsius class' do
      expect(subject.inflate_class('C', temperature).class).to be_a(Temperature::Celsius.class)
    end

    it 'when inflates Fahrenheit class' do
      expect(subject.inflate_class('F', temperature).class).to be_a(Temperature::Fahrenheit.class)
    end

    it 'when inflates Kelvin class' do
      expect(subject.inflate_class('K', temperature).class).to be_a(Temperature::Kelvin.class)
    end

    it 'when inflates unexpected class' do
      expect(subject.inflate_class('O', temperature).class).to eq(NilClass)
    end
  end

  describe '#convert' do
    temperature_inf = Temperature.new temperature

    it 'when converting to Celsius' do
      expect(temperature_inf).to receive(:to_celsius)
      subject.convert(temperature_inf, 'c')
    end

    it 'when converting to Fahrenheit' do
      expect(temperature_inf).to receive(:to_fahrenheit)
      subject.convert(temperature_inf, 'f')
    end

    it 'when converting to Kelvin' do
      expect(temperature_inf).to receive(:to_kelvin)
      subject.convert(temperature_inf, 'k')
    end

    it 'when converting to unexpected temperature type' do
      expect(subject.convert(temperature_inf, 'o')).to eq(nil)
    end
  end
end
