class ColumnsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  respond_to :json

  def index
    render json: User.find(params[:user_id]).columns
  end

  def show
    if Column.exists?(params[:id])
      render json: {
        status: { code: 200, message: 'Column was found'. },
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
        status: { code: 200, message: 'Column was created successfully.' },
        data: ColumnSerializer.new(@column).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Column couldn't be created successfully. #{@column.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end

  def update
    @column = Column.find_by(id: params[:id])

    if @column.nil?
      render json: { code: 404, message: 'Column was not found.' }, status: 404
      return
    end

    unless @column.user_id == current_user.id
      render json: { code: 405, message: 'You have no rights to update this column.' }, status: 405
      return
    end

    if @column.update(column_params)
      render json: {
        status: { code: 202, message: 'Column was updated successfully.' },
        data: ColumnSerializer.new(@column).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Column couldn't be updated successfully. #{@column.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end


  def destroy
    @column = Column.find_by(id: params[:id])

    if @column.nil?
      render json: { code: 404, message: 'Column was not found.' }, status: 404
      return
    end

    unless @column.user_id == current_user.id
      render json: { code: 405, message: 'You have no rights to delete this column.' }, status: 405
      return
    end

    @column.destroy
    render json: {}, status: 204
  end


  private

  def column_params
    params.require(:column).permit(:name)
  end
end
