class CharactersController < ApplicationController
  include ActiveModel::Serializers::JSON
  before_action :authenticate_user!
  def index
    if api_collection.any?
      options = {}
      options[:include] = [:movies]
      options[:is_collection] = [true]
      render json: CharacterSerializer.new(api_collection, options)
    else
      render json: {
        message: "#{current_user.email}, no hemos podido encontrar datos relacionados en la base de datos"
      }
    end
  end

  def api_collection
    if params[:name]
      Character.where(name: params[:name])
    elsif params[:age]
      Character.where(age: params[:age])
    elsif params[:weigth]
      Character.where(weigth: params[:weigth])
    else
      Character.all
    end
  end

  def create
    @character = Character.new(character_params)
    if @character.valid?
      @character.save!
      render json: @character
    else
      render json: {
        message: "Error al crear personaje. Motivos: #{error_messages}"
      }
    end
  end

  private

  def error_messages
    @character.errors.full_messages.join(" - ")
  end

  def character_params
    params.permit(:name, :age, :weigth, :history, :image_url, :character)
  end
end
