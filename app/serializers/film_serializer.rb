class FilmSerializer < ApplicationSerializer
  attributes :origin_title, :title, :year,
             :rating, :description, :avatar,
             :countries, :genres

  # has_many :genres
  # has_many :countries

  def attributes(*)
    hash = super
    hash = index_attributes(hash) if scope == :index
    hash
  end

  private

  def index_attributes(hash)
    {
      origin_title: hash[:origin_title],
      title: hash[:title],
      year: hash[:year],
      rating: hash[:rating],
      genres: hash[:genres],
      countries: hash[:countries]
    }
  end
end
