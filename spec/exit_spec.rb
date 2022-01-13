require_relative '../src/scenarious/exit'

RSpec.describe States::Exit do
  state = States::Exit.new

  it '#initialize' do
    expect(state.final_state).to eq(true)
  end

  it '#next' do
    expect(state.next).to eql(state)
  end
end
