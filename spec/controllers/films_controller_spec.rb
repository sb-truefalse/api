require 'rails_helper'

RSpec.describe Api::V1::FilmsController, type: :controller do
	describe '#index' do
		subject { get :index }

		it 'should return success return' do
			subject
			expect(response).to have_http_status(:ok)
		end	

		it 'should return proper json' do
			create_list :film, 2
			subject
			#expect(json_data.length).to eq(2)
			Film.recent.each_with_index do |film, index|
				expect(json_data[index]['attributes']).to eq({
					'title' => film.title,
					'description' => film.description,
					'countries' => [],
					'genres' => [],
					'origin-title' => film.origin_title,
					'rating' => film.rating,
					'year' => film.year,
					'avatar' => {"url" => nil}
				})
			end
		end

		it 'should return films in proper order' do
			old_film = create :film
			new_film = create :film
			subject
			expect(json_data.first['id']).to eq(new_film.id.to_s)
			expect(json_data.last['id']).to eq(old_film.id.to_s)
		end

		it 'should paginate results' do
			create_list :film, 3
			get :index, params: { page: 2, per_page: 1 }
			expect(json_data.length).to eq 1
			expected_film = Film.recent.second.id.to_s
			expect(json_data.first['id']).to eq(expected_film)			
		end
	end
	
	describe '#show' do
		let(:film) { create :film }
		subject { get :show, params: { id: film.id } }
    
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      expect(json_data['attributes']).to eq({
				'title' => film.title,
				'description' => film.description,
				'countries' => [],
				'genres' => [],
				'origin-title' => film.origin_title,
				'rating' => film.rating,
				'year' => film.year,
				'avatar' => {"url" => nil}
      })
    end
	end

	describe '#create' do
		context 'when invalid params provided' do
			let(:invalid_attributes) do
				{
					data: {
						attributes: {
							title: '',
						}
					}
				}
			end
			
			subject { post :create, params: invalid_attributes }
			
			it 'should return 422 status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
			end

			it 'should return proper error json' do
		    subject
		    expect(json['errors']).to include(
			    {
			      "source" => { "pointer" => "/data/attributes/title" },
			      "detail" => "can't be blank"
			    }
				)
			end
		end

		context 'when valid params provided' do
			let(:valid_attributes) do
				{
					data: {
						attributes: {
							title: 'Tekken 1',
						}
					}
				}
			end
			
			subject { post :create, params: valid_attributes }
			
			it 'should return proper json' do
		    subject
		    expect(json_data["attributes"]["title"]).to eq("Tekken 1")
			end
		end
	end

	describe '#update' do
		let(:film) { create :film }
		context 'when invalid params provided' do
			let(:invalid_attributes) do
				{
					data: {
						attributes: {
							title: '',
						}
					}
				}
			end
			
			subject { patch :update, params: invalid_attributes.merge(id: film.id) }
			
			it 'should return 422 status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
			end

			it 'should return proper error json' do
		    subject
		    expect(json['errors']).to include(
			    {
			      "source" => { "pointer" => "/data/attributes/title" },
			      "detail" => "can't be blank"
			    }
				)
			end
		end

		context 'when valid params provided' do
			let(:valid_attributes) do
				{
					data: {
						attributes: {
							title: 'Tekken 1.0',
						}
					}
				}
			end
			
			subject { put :update, params: valid_attributes.merge(id: film.id) }
			
      it 'should have 200 status code' do
        subject
        expect(response).to have_http_status(:ok)
      end
			
      it 'should have proper json body' do
        subject
        expect(json_data['attributes']['title']).to include(
          valid_attributes[:data][:attributes][:title]
        )
      end

      it 'should update the film' do
        subject
        expect(film.reload.title).to eq(
          valid_attributes[:data][:attributes][:title]
        )
      end
		end
	end

	describe '#destroy' do
		let(:film) { create :film }
		subject { delete :destroy, params: { id: film.id } }

	  it 'should have 204 status code' do
	    subject
	    expect(response).to have_http_status(:no_content)
	  end

	  it 'should have empty json body' do
	    subject
	    expect(response.body).to be_blank
		end

	  it 'should destroy the film' do
	  	film
	    expect{ subject }.to change{ Film.count }.by(-1)
		end
	end
end
