require 'rails_helper'

RSpec.describe Genre, type: :model do
	describe '#validations' do
	  it 'should test that the factory is valid' do
			expect(build :genre).to be_valid
	  end

	  it 'should validate the presence of the title' do
			film = build :genre, title: ''
			expect(film).not_to be_valid
			expect(film.errors.messages[:title]).to include("can't be blank")
	  end

	  it 'should validete uniqueness of the title' do
			genre = create :genre
			invalid_genre = build :genre, title: genre.title  	
			expect(invalid_genre).not_to be_valid
	  end
	end
end
