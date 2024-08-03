class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  respond_to :json

  def index
    render json: Card.find(params[:card_id]).comments
  end

  def show
    if Comment.exists?(params[:id])
      render json: {
        status: { code: 200, message: 'Comment was found.' },
        data: CommentSerializer.new(Comment.find(params[:id])).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 404, message: 'Comment was not found.'
      }
    end
  end

  def create
    @comment = current_user.comments.new(comment_params.merge(card_id: params[:card_id]))


    if @comment.save
      render json: {
        status: { code: 422, message: 'Comment was created successfully.' },
        data: CommentSerializer.new(@comment).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Comment couldn't be created successfully. #{@comment.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end

  def update
    @comment = Card.find_by(id: params[:card_id]).comments.find_by(id: params[:id])

    if @comment.nil?
      render json: { code: 404, message: 'Comment was not found.' }, status: 404
      return
    end

    unless @comment.user.id == current_user.id
      render json: { code: 405, message: 'You have no rights to update this comment.' }, status: 405
      return
    end

    if @comment.update(comment_params)
      render json: {
        status: { code: 202, message: 'Comment was updated successfully.' },
        data: CommentSerializer.new(@comment).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        code: 422, message: "Comment couldn't be updated successfully. #{@comment.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Card.find_by(id: params[:card_id]).comments.find_by(id: params[:id])

    if @comment.nil?
      render json: { code: 404, message: 'Comment was not found.' }, status: 404
      return
    end

    unless @comment.user.id == current_user.id
      render json: { code: 405, message: 'You have no rights to delete this comment.' }, status: 405
      return
    end

    @comment.destroy
    render json: {}, status: 204
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :card_id)
  end
end
