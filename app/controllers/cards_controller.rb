# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  respond_to :json

  def index
    render json: User.find(params[:user_id]).columns.find(params[:column_id]).cards
  end

  def show
    if Card.exists?(params[:id])
      render json: {
        status: { code: 200, message: 'Card was found.' },
        data: CardSerializer.new(Card.find(params[:id])).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 404, message: 'Card was not found.'
      }, status: 404
    end
  end

  def create
    @card = current_user.columns.find(params[:column_id]).cards.create(card_params)

    if @card.save
      render json: {
        status: { code: 200, message: 'Card was created successfully.' },
        data: CardSerializer.new(@card).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Card couldn't be created successfully. #{@card.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end

  def update
    @card = Column.find_by(id: params[:column_id]).cards.find(params[:id])

    if @card.nil?
      render json: { code: 404, message: 'Card was not found.' }, status: 404
      return
    end

    unless @card.column.user.id == current_user.id
      render json: { code: 405, message: 'You have no rights to update this card.' }, status: 405
    end

    if @card.update(card_params)
      render json: {
        status: { code: 202, message: 'Card was updated successfully.' },
        data: CardSerializer.new(@card).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Card couldn't be updated successfully. #{@card.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @card = Column.find_by(id: params[:column_id]).cards.find_by(id: params[:id])

    if @card.nil?
      render json: { code: 404, message: 'Column was not found.' }, status: 404
      return
    end

    unless @card.column.user.id == current_user.id
      render json: { code: 405, message: 'You have no rights to delete this card.' }, status: 405
      return
    end

    @card.destroy
    render json: {}, status: 204
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :column_id)
  end
end
