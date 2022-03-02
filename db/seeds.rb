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
# urls = ["https://avatars.githubusercontent.com/u/52168643?v=4", "https://avatars.githubusercontent.com/u/95384661?v=4", "https://avatars.githubusercontent.com/u/96342482?v=4", "https://avatars.githubusercontent.com/u/78359730?v=4"]
emails = ["peyrat.clement@gmail.com", "reynal.julie@gmail.com", "ouarzazi.sidney@gmail.com", "deguitre.canelle@gmail.com"]
passwords = ["adminp", "adminr", "admino", "admind"]
first_names = ["Clément", "Julie", "Sidney", "Canelle"]
last_names = ["Peyrat", "Reynal", "Ouarzazi", "Deguitre"]
usernames = ["cpeyrat", "jreynal", "souarzazi", "cdeguitre"]

user_index = 0
4.times do
  User.create!(
    email: emails[user_index],
    password: passwords[user_index],
    first_name: first_names[user_index],
    last_name: last_names[user_index],
    username: usernames[user_index]
  )
  # file_url = urls[i]
  # users_models = User.all
  # users_models[i].photo.attach(
  #   io: URI.open(file_url),
  #   filename: "file#{i}.jpg"
  # )
  user_index += 1
end
puts "Users creation done !"

puts "Creating feedbacks..."
statuses = ['Unwatched', 'Dislike', 'Like', 'Superlike']
comments = ['Nice tv show', 'Story is great', 'I liked the first season']
ratings = [3, 4, 5]
users = User.all
user_index = 0

4.times do
  tv_shows = TvShow.all
  3.times do
    tv_show = tv_shows.sample
    Feedback.create!(
      status: statuses.sample,
      user_id: users[user_index].id,
      tv_show_id: tv_show.id
    )
    tv_shows.reject { |show| show.id == tv_show.id }
  end
  2.times do
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

Follow.create!(
  follower_id: users[0].id,
  following_id: users[1].id
)
Follow.create!(
  follower_id: users[0].id,
  following_id: users[2].id
)
Follow.create!(
  follower_id: users[0].id,
  following_id: users[3].id
)
Follow.create!(
  follower_id: users[1].id,
  following_id: users[0].id
)
Follow.create!(
  follower_id: users[1].id,
  following_id: users[2].id
)
Follow.create!(
  follower_id: users[1].id,
  following_id: users[3].id
)
Follow.create!(
  follower_id: users[2].id,
  following_id: users[0].id
)
Follow.create!(
  follower_id: users[2].id,
  following_id: users[1].id
)
Follow.create!(
  follower_id: users[2].id,
  following_id: users[3].id
)
Follow.create!(
  follower_id: users[3].id,
  following_id: users[0].id
)
Follow.create!(
  follower_id: users[3].id,
  following_id: users[1].id
)
Follow.create!(
  follower_id: users[3].id,
  following_id: users[2].id
)
puts "Follows creation done !"
