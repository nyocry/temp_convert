require_relative '../src/scenarious/input_source_tempreture'

RSpec.describe States::InputSourceTemperature do
    
  state = States::InputSourceTemperature.new

  let(:io_mock) { instance_double IOAdapter }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  it '#initialize' do
    expect(state.final_state).to eq(false)
  end

  it '#render' do
    expect(state.render)
    expect(io_mock).to have_received(:write).with('Enter type of degrees (F,C,K), Q for exit: ')
  end

  context '#next' do
    it 'with correct input' do
      c = 'F'
      allow(io_mock).to receive(:read).and_return c

      actual_state = state.next
      expected_state = States::InputSourceTemperatureAmount.new(c)
      expect(actual_state.type_of_degrees).to eq(expected_state.type_of_degrees)
    end

    it 'with incorrect input' do
      c = '10'
      allow(io_mock).to receive(:read).and_return c
      allow(io_mock).to receive(:exit?).and_return false

      expect(state.next).to eq(state)
      expect(io_mock).to have_received(:write).with('Incorrect type')
    end

    it 'exit input' do
      c = 'q'
        
      allow(io_mock).to receive(:read).and_return c
      allow(io_mock).to receive(:exit?).and_return c

      expect(state.next).to be_a(States::Exit)
    end
  end
end
