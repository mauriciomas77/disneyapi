class MoviesController < ApplicationController
  before_action :authenticate_user!
  def index
    options = {}
    options[:is_collection] = [true]
    options[:include] = [:genre]
    render json: MovieSerializer.new(api_collection, options)
  end

  def api_collection
    Movie.all
  end
end
