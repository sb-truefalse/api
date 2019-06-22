class FilmSerializer < ApplicationSerializer
	#set_type :films
	#set_id :owner_id # optional
  attributes :origin_title, :title, :year, :rating, :description, :avatar, :countries, :genres
  #has_many :genres
  #has_many :countries
end
