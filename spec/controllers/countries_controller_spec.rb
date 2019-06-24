require 'rails_helper'

RSpec.describe Api::V1::CountriesController, type: :controller do
	describe '#index' do
		subject { get :index }
		it 'should return success return' do
			subject
			expect(response).to have_http_status(:ok)
		end
		
		it 'should return proper json' do
			subject
			expect(json_data.count).to eq(Country.count)
		end
	end
	
end