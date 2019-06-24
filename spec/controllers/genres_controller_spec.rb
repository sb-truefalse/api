require 'rails_helper'

RSpec.describe Api::V1::GenresController, type: :controller do
	describe '#index' do
		subject { get :index }
		it 'should return success return' do
			subject
			expect(response).to have_http_status(:ok)
		end

		it 'should return proper json' do
			genre = create :genre, title: 'fun'
			subject
				expect(json_data[0]['attributes']).to eq({
				  'title' => genre.title
			})
		end
	end
	
end