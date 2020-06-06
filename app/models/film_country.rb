class FilmCountry < ApplicationRecord
  belongs_to :film
  validates :film, uniqueness: { scope: :country }
  validates :country, presence: true
end
