class CommentController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  respond_to :json

  def index
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
