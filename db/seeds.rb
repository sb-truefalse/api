GEN_SEED = ENV.fetch('GEN_SEED', false)

LOREM_IPSUM = <<~HEREDOC
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
HEREDOC

FILM_NAMES = [
  { en: 'Spider Man', ru: 'Человек Паук' },
  { en: 'Nu pogodi!', ru: 'Ну погоди' },
  { en: 'Tom & Jerry', ru: 'Том и Джери' },
  { en: 'Neznaika', ru: 'Незнайка' }
]

LIST_GENRES = [
  { title: 'comedy' },
  { title: 'horror' },
  { title: 'drama' },
  { title: 'thriller' },
  { title: 'fantasy' },
  { title: 'cartoon' }
]

def list_films
  [
    generate_films(5, local: 'en', title: FILM_NAMES[0][:en], country: 'US'),
    generate_films(5, local: 'ru', title: FILM_NAMES[1][:en], country: 'RU'),
    generate_films(5, local: 'en', title: FILM_NAMES[2][:en], country: 'US'),
    generate_films(5, local: 'ru', title: FILM_NAMES[3][:en], country: 'RU')
  ]
end

def avatar
  File.open(ENV['AVATAR_PATH'])
rescue
end

def generate_films(count, opts={})
  (1..count).map do |i|
    {
      local: opts[:local],
      title: "#{opts[:title]} #{i}",
      description: LOREM_IPSUM,
      date: Date.new(2010 + i + 1, 1, 1),
      rating: i,
      avatar: avatar,
      genre_ids: [i, 6],
      film_countries_attributes: [
        { country: 'CN' }, { country: opts[:country] }
      ],
      locale: I18n.default_locale
    }
  end
end

Genre.create(LIST_GENRES) if GEN_SEED

if GEN_SEED
  group_films = Film.create(list_films)
  group_films.each_with_index do |films, i|
    films.each_with_index do |film, j|
      film.update_attributes(
        { title: "#{FILM_NAMES[i][:ru]} #{j + 1}", locale: :ru }
      )
    end
  end
end
