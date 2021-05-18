class MovieSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :genre
  attributes :id, :title, :released_year, :rating, :image_url
end
