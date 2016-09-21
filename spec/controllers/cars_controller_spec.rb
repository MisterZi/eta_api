require 'rails_helper'

RSpec.describe CarsController, type: :controller do

  context 'index' do
    it 'test' do
      FactoryGirl.create(:car)
      FactoryGirl.create(:car, position: "59.6888866 30.43916702", available: true)
      FactoryGirl.create(:car, position: "59.69079255 30.44843674", available: true)

      get :index, position: "[59.68420789, 30.44878006]"
      expect(response.body).not_to be_nil
      expect(response.body).to be_a(String)

    end
  end

end
