class Film < ApplicationRecord
  has_many :film_genres
  has_many :genres, -> { select(:id, :title) }, through: :film_genres
  has_many :film_countries, dependent: :destroy
  accepts_nested_attributes_for :film_countries
  
  mount_uploader :avatar, AvatarUploader
  translates :title, fallbacks_for_empty_translations: true
  
  validates :title, presence: true
  validates :rating, inclusion: { in: 1..10, message: "must be range 0..10" }, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }
  before_create :locale_default

  def locale
    self.local.try(:to_sym) || I18n.default_locale
  end

  def origin_title
    title(locale)
  end

  def countries
    film_countries.map do |f_c| 
      country = ISO3166::Country[f_c.country]
      {id: country.alpha2, name: country.translations[I18n.locale.to_s]}
    end
  end

  def year
    self.date.try(:year)
  end

  def locale_default
    self.local||= I18n.default_locale.to_s
  end

  def self.filtered(filters)
    films = self
    films = films.search(filters[:title]) if filters.include? :title
    films = films.by_year(filters[:year]) if filters.include? :year
    films = films.by_country(filters[:country]) if filters.include? :country
    films = films.where(rating: filters[:rating]) if filters.include? :rating
    films = films.by_genres(filters[:genres]) if filters.include? :genres
    return films
  end

  def self.sorted(sort)
    case
    when sort[:year]
      order(date: sort[:year])
    when sort[:rating]
      order(rating: sort[:rating])
    else
      order(created_at: :desc) # order(nil)
    end
  end

  def self.by_year(year)
    where('extract(year from date) = ?', year)
  end

  if Rails.configuration.database_configuration[Rails.env].try(:[], 'adapter')
    def self.by_year(year)
      where("cast(strftime('%Y', date) as int) = ?", year)
    end
  end

  def self.by_genres(code)
    joins(:genres).where(genres: { id: genres })
  end

  def self.by_country(genres)
    joins(:film_countries).where(film_countries: { country: genres })
  end

  def with_translations(*locales)
    locales||= translated_locales
    includes(:translations).with_locales(I18n.locale.to_s).with_required_attributes
  end
  
  def self.search(search)
    if search
      with_translations.where('title LIKE ?', "%#{search}%")
    else
      with_translations
    end
  end

end
