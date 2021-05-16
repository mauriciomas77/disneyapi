class CharactersController < ApplicationController
  before_action :authenticate_user!
  def index
    @characters = Character.includes(:characters_movies, :movies).all
    options = {}
    options[:include] = [:movies]
    options[:is_collection] = [true]
    render json: CharacterSerializer.new(@characters, options)
    # data = @characters.each do |char|
    #   options = {}
    #   options[:include] = [:movies, :'movie.title']
    #   CharacterSerializer.new([char,char], options).serialized_json
    #   #.serializable_hash[:data][:attributes]
    # end
    # render json: {
    #   status: { code: 200, message: 'Operación autenticada' },
    #   data: data
    # }, status: :ok
  end
end
