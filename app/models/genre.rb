class Genre < ApplicationRecord
  has_many :film_genres
  has_many :films, through: :film_genres

  validates :title, presence: true, uniqueness: true
end
