# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying tv shows..."
TvShow.destroy_all
puts "Destroying follows..."
Follow.destroy_all
puts "Destroying users..."
User.destroy_all
puts "Destroying feedbacks..."
Feedback.destroy_all
puts "Destroying wishes..."
Wish.destroy_all
puts "Done: database clean !"

puts "Creating TV shows"

i = 0
require 'open-uri'
tv_shows = JSON.parse(URI.open("http://tmdb.lewagon.com/discover/tv?with_watch_providers=8|119|337|381|56&watch_region=FR&sort_by=popularity.desc").read)["results"]
tv_shows.each do |tv_show|
  tv_show_episodes_count = JSON.parse(URI.open("http://tmdb.lewagon.com/tv/#{tv_show['id']}").read)["number_of_episodes"]
  tv_show_seasons_count = JSON.parse(URI.open("http://tmdb.lewagon.com/tv/#{tv_show['id']}").read)["number_of_seasons"]
  poster_url = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/#{tv_show['poster_path']}"
  director = JSON.parse(URI.open("http://tmdb.lewagon.com/tv/#{tv_show['id']}").read)["created_by"][0]["name"]
  genre = JSON.parse(URI.open("http://tmdb.lewagon.com/tv/#{tv_show['id']}").read)['genres'][0]['name']
  tv_show_french_providers_details = JSON.parse(URI.open("http://tmdb.lewagon.com/tv/#{tv_show['id']}/watch/providers").read)["results"]["FR"]["flatrate"]
  tv_show_french_providers = tv_show_french_providers_details.map { |provider| provider["provider_id"] }
  amazon_provider_id = 119
  netflix_provider_id = 8
  disney_provider_id = 337
  canal_provider_id = 381
  ocs_provider_id = 56
  TvShow.create!(
    title: tv_show['name'],
    description: tv_show['overview'],
    imdb_rating: tv_show['vote_average'],
    language: tv_show['original_language'],
    genre: genre,
    episodes_count: tv_show_episodes_count,
    seasons_count: tv_show_seasons_count,
    amazon: tv_show_french_providers.include?(amazon_provider_id),
    netflix: tv_show_french_providers.include?(netflix_provider_id),
    disney: tv_show_french_providers.include?(disney_provider_id),
    canal: tv_show_french_providers.include?(canal_provider_id),
    ocs: tv_show_french_providers.include?(ocs_provider_id),
    poster_url: poster_url,
    director: director
  )
  i += 1
end

puts "TV shows creation done !"

puts "Creating users..."
urls = ["https://avatars.githubusercontent.com/u/52168643?v=4", "https://avatars.githubusercontent.com/u/95384661?v=4", "https://avatars.githubusercontent.com/u/96342482?v=4", "https://avatars.githubusercontent.com/u/78359730?v=4","https://avatars.githubusercontent.com/u/93845046?v=4", "https://avatars.githubusercontent.com/u/93552707?v=4", "https://avatars.githubusercontent.com/u/93259262?v=4", "https://avatars.githubusercontent.com/u/95241063?v=4"]
emails = ["peyrat.clement@gmail.com", "reynal.julie@gmail.com", "ouarzazi.sidney@gmail.com", "deguitre.canelle@gmail.com","teddy@gmail.com", "thomas@gmail.com", "gala@gmail.com", "lucien@gmail.com"]
passwords = ["adminp", "adminr", "admino", "admind", "admint", "admint", "adming", "adminkl"]
first_names = ["Clément", "Julie", "Sidney", "Canelle", "Teddy", "Thomas", "Gala", "Lucien"]
last_names = ["Peyrat", "Reynal", "Ouarzazi", "Deguitre", "Bandama", "Loubet", "Thevenet", "Lagorce"]
usernames = ["cpeyrat", "jreynal", "souarzazi", "cdeguitre", "tbandama", "tloubet", "gthevenet", "llagorce"]

user_index = 0
8.times do
  User.create!(
    email: emails[user_index],
    password: passwords[user_index],
    first_name: first_names[user_index],
    last_name: last_names[user_index],
    username: usernames[user_index],
    facebook_picture_url: urls[user_index]
  )
  user_index += 1
end
puts "Users creation done !"

puts "Creating feedbacks..."
statuses = ['Unwatched', 'Dislike', 'Like', 'Superlike']
comments = ["The beginning of the tv show is very great. Unfortunately the final season is not as exciting as the first ones but still worth binge watching it !", "Actors are marvellous and story is great. You wont get bored if you decide to watch it", "I liked it from beginning to end. You should definitely wathc it !", "I think this is the best tv show ever", "A bit disappointing even if actors are good.", "THAT'S THE BEST SHOW EVER!!!!", "Characters are very well defined. Synopsis is intelligently done.But still at the end, I was annoyed when I watched it..."]
ratings = [3, 4, 5]
users = User.all
user_index = 0

8.times do
  tv_shows = TvShow.all
  5.times do
    tv_show = tv_shows.sample
    Feedback.create!(
      status: statuses.sample,
      user_id: users[user_index].id,
      tv_show_id: tv_show.id
    )
    tv_shows.reject { |show| show.id == tv_show.id }
  end
  5.times do
    tv_show = tv_shows.sample
    Feedback.create!(
      status: ['Like', 'Superlike'].sample,
      user_id: users[user_index].id,
      tv_show_id: tv_shows.sample.id,
      comment: comments.sample,
      rating: ratings.sample
    )
    tv_shows.reject { |show| show.id == tv_show.id }
  end
  user_index += 1
end

puts "Feedbacks creation done !"

puts "Creating follows..."
users = User.all

follower_index = 0
8.times do
  following_index = 0
  8.times do
    if follower_index != following_index
      Follow.create!(
        follower_id: users[follower_index].id,
        following_id: users[following_index].id
      )
    end
    following_index += 1
  end
  follower_index += 1
end

puts "Follows creation done !"
