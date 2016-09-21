require 'rails_helper'

RSpec.describe Car, type: :model do

  # Проверяем наличие валидаций
  context 'validations check' do
    it { should validate_presence_of :position }
    it { should validate_presence_of :available }
  end

  # Проверяем работоспособность методов расчета ETA
  context 'ETA check' do

    # ETA для одной машины
    it 'calculate ETA' do
      car = FactoryGirl.create(:car)
      user_position = ['59.68420789', '30.44878006']
      expect(car.eta(user_position)).not_to be_nil
      expect(car.eta(user_position)).not_to eq(0)
    end

    # среднее ETA
    it 'caclulate average_ETA' do
      car = FactoryGirl.create(:car)
      user_position = ['59.68420789', '30.44878006']
      expect(Car.average_eta(Car.all, user_position)).not_to be_nil
    end
  end
end
