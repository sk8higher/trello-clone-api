class CardSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :column_id
end
