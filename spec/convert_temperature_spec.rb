require_relative '../src/scenarious/convert_temperature'
require_relative '../src/io_adapter'

RSpec.describe States::ConvertTemperature do
  type_of_degrees = 'F'
  temperature_amount = 34.0
  to_type = 'C'
  state = States::ConvertTemperature.new(type_of_degrees, temperature_amount, to_type)

  let(:io_mock) { instance_double IOAdapter }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  it '#initialize' do
    expect(state.type_of_degrees).to eq(type_of_degrees)
    expect(state.temperature_amount).to eq(temperature_amount)
    expect(state.to_type).to eq(to_type)
    expect(state.final_state).to eq(false)
  end

  it '#next' do
    temperature_inf = Temperature::Fahrenheit.new(temperature_amount)
    converted_temperature = Temperature::Celsius.new(temperature_amount)

    temperature_handler_mock = instance_double TemperatureHandler
    allow(TemperatureHandler).to receive(:instance).and_return(temperature_handler_mock)
    allow(temperature_handler_mock).to receive(:inflate_class).with(type_of_degrees, temperature_amount).and_return temperature_inf
    allow(temperature_handler_mock).to receive(:convert).with(temperature_inf, to_type).and_return converted_temperature

    expect(state.next).to be_a(States::Exit)
    expect(temperature_handler_mock).to have_received(:inflate_class).with(type_of_degrees, temperature_amount)
    expect(temperature_handler_mock).to have_received(:convert).with(temperature_inf, to_type)
    expect(io_mock).to have_received(:write).with(converted_temperature.value)
  end
end
