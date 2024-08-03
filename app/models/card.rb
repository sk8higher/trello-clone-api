# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :column
  has_many :comments

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
