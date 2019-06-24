class FilmSerializer < ApplicationSerializer
	#set_type :films
	#set_id :owner_id # optional
  attributes :origin_title, :title, :year, :rating, :description, :avatar, :countries, :genres
  #has_many :genres
  #has_many :countries
  
  def attributes(*)
    hash = super
    hash = index_attributes(hash) if :index == scope
    hash
  end

  private
  def index_attributes(hash)
  	{
      origin_title: hash[:origin_title],
      title: hash[:title],
    }
  end
end
