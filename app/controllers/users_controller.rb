# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :json

  def show
    if User.exists?(params[:id])
      render json: {
        status: { code: 200, message: 'User was found.' },
        data: UserSerializer.new(User.find(params[:id])).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 404, message: 'User was not found.'
      }, status: 404
    end
  end
end
