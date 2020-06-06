# RESTful JSON API «KINO»
* Format url: `api/v1/:LOCALE/RESOURCE`
* Locale support: `en` `ru` 
* Locale default: `en` 

## FILMS
* RESOURCE: `films`
* MOVIE INFO:   `origin_title` `title` `year` `rating` `description` `avatar` `countries` `genres`
* MOVIE FILTERS: `title` `year` `rating` `country` `genres`
* MOVIE SORT [asc | desc]:  `year` `rating`
* MOVIE ATTRIBUTE: `local` `title` `date` `description` `rating` `avatar` `genre_ids` `film_countries_attributes`

method  |path| params|action|
------------- |-------------| -------------| -------------
get  | /|filters[:filter], sort[:sort], page, per_page|movie list
get  |/:id||movie info
post|/|data[attributes[:attribute]]|movie create
put|/:id|data[attributes[:attribute]]|movie update
delete|/:id| |movie delete

* **Note 1:** filters[genres][]=1&filters[genres][]=2...
* **Note 2:** filters by genre and country use ID (_see next_)
* **Note 3:** data[attributes[genre_ids]][]=1&data[attributes[genre_ids]][]=2
* **Note 4:** data[attributes[film_countries_attributes[][country]]]=RU&data[attributes[film_countries_attributes[][country]]]=CH
* **Note 5:** to create a new translation for title, use param locale

> /api/v1/films?page=1&per_page=1

> /api/v1/ru/films?filters[rating]=2&filters[year]=2013&sort[rating]=asc

> /api/v1/films?filters[genres][]=1&filters[genres][]=2&filters[country]=RU

## GENRES
RESOURCE: `genres`

method  |path| params|action|
------------- |-------------| -------------| -------------
get  |/| |genres list

## COUNTRIES
RESOURCE: `countries`

method  |path |params|action|
------------- |-------------| -------------| -------------
get |/||countries list

## How to install and run (development)
```bash
git clone git@github.com:sb-truefalse/kino_api.git
bundle install
rails db:migrate
AVATAR_PATH=:image_path GEN_SEED=true rails db:seed # optional
rails s
```