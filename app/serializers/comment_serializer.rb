# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :card_id, :user_id
end
