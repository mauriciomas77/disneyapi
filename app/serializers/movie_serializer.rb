class MovieSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :released_year, :rating
end
