require "rails_helper"

describe 'films routes' do
	it 'should route to films index' do
		expect(get '/api/v1/films').to route_to('api/v1/films#index')
	end

	it 'should route to films show' do
		expect(get '/api/v1/films/1').to route_to('api/v1/films#show', id: '1')
	end	

	it 'should route to films create' do
		expect(post '/api/v1/films').to route_to('api/v1/films#create')
	end

	it 'should route to films update' do
		expect(put '/api/v1/films/1').to route_to('api/v1/films#update', id: '1')
	end
	
	it 'should route to films destroy' do
    expect(delete '/api/v1/films/1').to route_to('api/v1/films#destroy', id: '1')
  end

end
