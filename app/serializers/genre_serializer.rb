class GenreSerializer
  include FastJsonapi::ObjectSerializer
  has_many :movies
  attributes :id, :genre_name, :image_url
end
