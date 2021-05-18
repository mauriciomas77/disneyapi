class Character < ApplicationRecord
  # attr_accessor :characters_movie_ids, :characters_movies
  validates :name, presence: true, uniqueness: true
  validates :age, presence: true

  has_and_belongs_to_many :movies
end
