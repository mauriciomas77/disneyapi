class Character < ApplicationRecord
  attr_accessor :characters_movie_ids, :characters_movies

  has_and_belongs_to_many :movies
end
