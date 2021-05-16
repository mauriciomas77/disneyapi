class CharacterSerializer
  include FastJsonapi::ObjectSerializer
  set_type :character

  has_many :movies, through: :characters_movies, serializer: MovieSerializer
  # has_many :movies, through: :characters_movies
  attributes :id, :name, :age, :weigth, :history, :image_url
end
