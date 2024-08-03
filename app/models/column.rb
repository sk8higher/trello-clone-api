class Column < ApplicationRecord
  belongs_to :user
  has_many :cards

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
end
