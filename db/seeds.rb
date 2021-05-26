# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  Character,
  Movie,
  Genre,
].each { |model_class| model_class.destroy_all }
puts "Clearing database"


def film_data(movie)
  require 'uri'
  require 'net/http'
  require 'openssl'

  url = URI("https://imdb8.p.rapidapi.com/title/find?q=#{movie.title}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = 'b61333a7fdmsh72ee161691e047cp15707bjsn87c2ca799fb0'
  request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

  response = http.request(request)
  myjson = JSON.parse(response.read_body)
  year = myjson["results"].first["year"] || nil
  image = myjson["results"].first["image"]["url"] || nil
  genre = myjson["results"].first["titleType"]    || nil
  {
    year: year,
    image: image,
    genre: genre
  }
rescue
  {
    year: nil,
    image: nil,
    genre: nil
  }
end


require 'json'

filepath = 'db/characters.json'

serialized_chars = File.read(filepath)

characters = JSON.parse(serialized_chars)

iterator = 1
characters["data"].each_with_index do |char, indx|
  character = Character.new(
                            name: char["name"],
                            age: rand(10..90),
                            weigth: rand(30.0..90),
                            history: "This is the history of #{char["name"]}",
                            image_url: char["imageUrl"])
  character.save!(validate: false)
  movies_array = characters["data"][indx]["films"]
  movies_array.each do |film|
    sleep 1
    puts "Movie number #{iterator} created"
    mov = Movie.new(title: film,
                    rating: rand(1..5))
    movie_hash = film_data(mov)
    mov.released_year = movie_hash[:year]
    mov.image_url = movie_hash[:image]
    unless Genre.where(genre_name: movie_hash[:genre]).any?
      genre = Genre.new(genre_name: movie_hash[:genre])
      genre.save!
    end
    genre ||= Genre.where(genre_name: movie_hash[:genre]).first
    mov.genre = genre
    character.movies << mov
    mov.save!
    iterator += 1
  end
end
