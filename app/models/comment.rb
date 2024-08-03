# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5, maximum: 300 }
end
