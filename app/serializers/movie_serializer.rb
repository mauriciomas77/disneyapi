class MovieSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :genre
  attributes :id, :title, :released_year, :image_url
end
