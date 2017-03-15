require 'spec_helper'

RSpec.describe Kele do
  it 'has a version number' do
    expect(Kele::VERSION).not_to be nil
  end
end

#   it 'does something useful' do
#     expect(false).to eq(true)
#   end
# end

describe '#initialize' do

  it 'raises InvalidCredentials error' do
    expect { Kele.new(ENV['EMAIL'], ENV['PASSWORD']) }.to raise_error(InvalidCredentialsError)
  end

  it 'authenticates user' do
    response = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
    expect(response.instance_variable_get(:@auth_token)).to be_a(String)
  end
end
