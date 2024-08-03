# frozen_string_literal: true

class ColumnSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :user_id
end
