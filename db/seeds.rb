Lorem_Ipsum = %Q(Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
)
Avatar = File.open(ENV['AVATAR_URL']) rescue nil

def generate_films(count, opts={})
  (1..count).map do |i|
    {
      local: opts[:local],
      title: "#{opts[:title]} #{i}",
      description: Lorem_Ipsum,
      date: Date.new(2010+i,1,1),
      rating: i,
      avatar: Avatar,
      genre_ids: [ i, 6],
      film_countries_attributes: [{country: 'RU'}, {country: 'UA'}],
    }
  end
end

if true
  Genre.create([
    {title: 'comedy'},
    {title: 'horror'},
    {title: 'drama'},
    {title: 'thriller'},
    {title: 'fantasy'},
    {title: 'cartoon'},
  ])
end

if true
  Film.create([
    generate_films(5, local: 'en', title: "Spider Man"),
    generate_films(5, local: 'ru', title: "Ну погоди!"),
    generate_films(5, local: 'en', title: "Tom & Jerry"),
    generate_films(5, local: 'ru', title: "Незнайка"),
  ])
end