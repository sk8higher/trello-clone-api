class ColumnSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :user_id
end
