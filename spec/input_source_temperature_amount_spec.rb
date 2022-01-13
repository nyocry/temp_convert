require_relative '../src/scenarious/input_source_temperature_amount'
require_relative '../src/io_adapter'

RSpec.describe States::InputSourceTemperatureAmount do
  type_of_degrees = 'k'
  state = States::InputSourceTemperatureAmount.new(type_of_degrees)

  let(:io_mock) { instance_double IOAdapter }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  it '#initialize' do
    expect(state.type_of_degrees).to eq(type_of_degrees)
    expect(state.final_state).to eq(false)
  end

  it '#render' do
    state.render
    expect(io_mock).to have_received(:write).with('Enter temperature amount: ')
  end

  context '#next' do
    it 'with correct input as number' do
      t = '34.0'
      allow(io_mock).to receive(:read).and_return t
      actual_state = state.next
      expected_state = States::InputTargetTemperature.new(type_of_degrees, t)

      expect(actual_state.type_of_degrees).to eq(expected_state.type_of_degrees)
      expect(actual_state.temperature_amount).to eq(expected_state.temperature_amount)
    end

    it 'with incorrect input as not number' do
      allow(io_mock).to receive(:read).and_return 'asdad'
        
      expect(state.next).to eq(state)
      expect(io_mock).to have_received(:write).with('Incorrect number')
    end
  end
end
