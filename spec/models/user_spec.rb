require 'rails_helper'

describe User do
  describe '#valid?' do
    context 'when password is shorter than 8 characters' do
      it 'is not valid' do
        user = User.new(email: 'uesteibar@gmail.com', password: 'Ale8', name: 'Unai', surname: 'Esteibar')

        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to eq(["is too short (minimum is 8 characters)"])
      end
    end

    context 'when password is longer than 8 characters' do
      context 'when it has numbers and lower and upper case letters' do
        it 'is valid' do
          user = User.new(email: 'uesteibar@gmail.com', password: 'Ale8kaka', name: 'Unai', surname: 'Esteibar')

          expect(user).to be_valid
        end
      end

      context 'when it doesn\'t have numbers' do
        it 'is not valid' do
          user = User.new(email: 'uesteibar@gmail.com', password: 'Alenguapo', name: 'Unai', surname: 'Esteibar')

          expect(user).not_to be_valid
          expect(user.errors.messages[:password]).to eq(['must have at least one uppercase letter, one lowercase letter and one number']) 
        end
      end

      context 'when it doesn\'t have lowercase letters' do
        it 'is not valid'
      end

      context 'when it doesn\'t have uppercase letters' do
        it 'is not valid'
      end
    end
  end
end
