class Movie < ApplicationRecord
  has_and_belongs_to_many :characters
  belongs_to :genre
end
