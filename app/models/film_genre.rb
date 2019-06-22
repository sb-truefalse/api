class FilmGenre < ApplicationRecord
  belongs_to :film
  belongs_to :genre
	validates :film, uniqueness: { scope: :genre }
end
