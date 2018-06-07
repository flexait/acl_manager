require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_parameters) {
    {
      email: 'john@email.com',
      password: '123456789'
    }
  }
  
  describe '#create!' do
    context 'with invalid parameter' do
      it 'email' do
        expect {
          User.create!(email: 'john')
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with valid parameters' do
      it 'should be success' do
        user = User.create!(valid_parameters)
        expect(user).to eq(User.first)
      end
    end
  end
end
