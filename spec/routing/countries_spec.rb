require "rails_helper"

describe 'genres routes' do
	it 'should route to countries index' do
		expect(get '/api/v1/countries').to route_to('api/v1/countries#index')
	end
end
