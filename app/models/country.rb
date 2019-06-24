class Country < ApplicationRecord
	def self.all
		ISO3166::Country.all.map do |country|
      {
        id: country.alpha2,
        name: country.translations[I18n.locale.to_s]
      }
    end
	end

	def self.count
	  ISO3166::Country.all.count
	end

	def self.serializer(countries)
		countries.class == Array ?
		  { data: countries.map { |country|  _serializer(country) } } : 
		    { data: _serializer(countries) }
	end

	private
	def self._serializer(country)
		{
			type: :countries,
			id: country[:id],
			attributes: {
				name: country[:name],
			}
		}
	end
end