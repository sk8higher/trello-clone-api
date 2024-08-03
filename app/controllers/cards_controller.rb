class CardsController < ApplicationController
  before_action :authenticate_user!, except [:index, :show]
  respond_to :json

  def index
    @cards = current_user.cards
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
