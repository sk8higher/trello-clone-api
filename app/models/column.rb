class Column < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
end
