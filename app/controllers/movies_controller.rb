class MoviesController < ApplicationController
  before_action :authenticate_user!
  def index
    options = {}
    options[:is_collection] = [true]
    options[:include] = [:genre]
    render json: MovieSerializer.new(api_collection, options)
  end

  def show
    if movie_exist?
      options = {}
      options[:include] = [:characters]
      render json: {
        message: 'Película o serie encontrada',
        movie: find_movie,
        characters: find_movie.characters
      }
    else
      render json: {
        message: "La Película no se encontró en la base de datos"
      }
    end
  end

  private

  def api_collection
    if params[:title]
      Movie.where(title: params[:title])
    elsif params[:genre]
      Movie.where(genre_id: params[:genre])
    elsif params[:order]
      case params[:order]
      when "ASC"
        Movie.order(:title)
      when "DESC"
        Movie.order(title: :desc)
      end
    else
      Movie.all
    end
  end

  def find_movie
    Movie.find(movie_params[:id])
  end

  def movie_exist?
    Movie.exists?(movie_params[:id])
  end

  def movie_params
    params.permit(:id, :title, :released_year, :rating, :image_url)
  end
end
