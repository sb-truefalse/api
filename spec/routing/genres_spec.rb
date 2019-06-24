require "rails_helper"

describe 'genres routes' do
	it 'should route to genres index' do
		expect(get '/api/v1/genres').to route_to('api/v1/genres#index')
	end
end
