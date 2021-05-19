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
    character = Character.new(character_params)
    if character.valid?
      character.save!
      render json: character
    else
      render json: {
        message: "Error al crear personaje. Motivos: #{error_messages}"
      }
    end
  end

  def update
    if character_exist
      character = find_character
      character.update_attributes(character_params)
      render json: {
        message: "Se actualizó el personaje #{character_params[:id]}",
        character: character
      }
    else
      render json: {
        message: "No se encontró un personaje con id #{character_params[:id]}"
      }
    end
  end

  def destroy
    if character_exist
      find_character.destroy!
      render json: {
        message: "El personaje con id #{character_params[:id]} ha sido borrado"
      }
    else
      render json: {
        message: "No se encontró el personaje con id #{character_params[:id]}"
      }

    end
  end

  def show
    if character_exist?
      options = {}
      options[:include] = [:movies]
      render json: {
        message: 'Personaje encontrado',
        character: CharacterSerializer.new(find_character, options)
      }
    else
      render json: {
        message: "El personaje no se encontró en la base de datos"
      }
    end
  end

  private

  def find_character
    Character.find(character_params[:id])
  end

  def character_exist?
    Character.exists?(id: params[:id])
  end

  def error_messages
    character.errors.full_messages.join(" - ")
  end

  def character_params
    params.permit(:id, :name, :age, :weigth, :history, :image_url, :character)
  end
end
