require 'rails_helper'

RSpec.describe Film, type: :model do
  
  describe '#validations' do
	  it 'should test that the factory is valid' do
			expect(build :film).to be_valid
	  end

	  it 'should validate the presence of the title' do
			film = build :film, title: ''
			expect(film).not_to be_valid
			expect(film.errors.messages[:title]).to include("can't be blank")
	  end

	  it 'should validate the more 10 of the rating' do
			film = build :film, rating: 11
			expect(film).not_to be_valid
			expect(film.errors.messages[:rating]).to include("must be range 0..10")
	  end

	  it 'should validate the less 0 of the rating' do
			film = build :film, rating: -1
			expect(film).not_to be_valid
			expect(film.errors.messages[:rating]).to include("must be range 0..10")
	  end
	end

	describe '.recent' do
	  it 'should list recent film first' do
	  	old_film = create :film
			new_film = create :film
			expect(described_class.recent).to eq(
				[new_film, old_film]
			)
			old_film.update_column :created_at, Time.now
			expect(described_class.recent).to eq(
				[old_film, new_film]
			)
	  end
	end

end
