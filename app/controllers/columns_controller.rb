class ColumnsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def show
    if Column.exists?(params[:id])
      render json: {
        status: { code: 200, message: 'Column was found' },
        data: ColumnSerializer.new(Column.find(params[:id])).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 404, message: 'Column was not found.'
      }, status: 404
    end
  end

  def create
    @column = current_user.columns.create(column_params)

    if @column.save
      render json: {
        status: { code: 200, message: 'Column was successfully created.' },
        data: ColumnSerializer.new(@column).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Column couldn't be created successfully. #{@column.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end

  private

  def column_params
    params.require(:column).permit(:name)
  end
end
