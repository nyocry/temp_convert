require_relative '../src/scenarious/input_target_temperature'
require_relative '../src/io_adapter'
require_relative '../src/scenarious/convert_temperature'

RSpec.describe States::InputTargetTemperature do
  type_of_degrees = 'k', 
                    temperature_amount = '34.0'
  state = States::InputTargetTemperature.new(type_of_degrees, temperature_amount)

  let(:io_mock) { instance_double IOAdapter }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  it '#initialize' do
    expect(state.type_of_degrees).to eq(type_of_degrees)
    expect(state.temperature_amount).to eq(temperature_amount)
    expect(state.final_state).to eq(false)
  end

  it '#render' do
    state.render
    expect(io_mock).to have_received(:write).with('Convert to (F, C, K): ')
  end

  context '#next' do
    let(:temperature_handler_mock) { instance_double TemperatureHandler }
    before do
      allow(TemperatureHandler).to receive(:instance).and_return(temperature_handler_mock)
    end

    it 'with correct conversation type' do
      to_type = 'C'
      allow(io_mock).to receive(:read).and_return(to_type)
      allow(temperature_handler_mock).to receive(:correct_temperature_type?).and_return true
        
      actual_state = state.next
      expected_state = States::ConvertTemperature.new(type_of_degrees, temperature_amount, to_type)
        
      expect(temperature_handler_mock).to have_received(:correct_temperature_type?).with(to_type)
      expect(actual_state.type_of_degrees).to eq(expected_state.type_of_degrees)
      expect(actual_state.temperature_amount).to eq(expected_state.temperature_amount)
      expect(to_type).to eq(expected_state.to_type)
    end

    it 'with incorrect conversation type' do
      to_type = 'Hohma'
      allow(io_mock).to receive(:read).and_return(to_type)
      allow(temperature_handler_mock).to receive(:correct_temperature_type?).and_return false

      expect(state.next).to eq(state)
      expect(io_mock).to have_received(:write).with('Incorrect input')
    end
  end
end
