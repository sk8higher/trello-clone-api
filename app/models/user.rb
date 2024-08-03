# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, format: { with: Devise.email_regexp }, presence: true
  validates :password, length: { minimum: 8 }, presence: true

  has_many :columns
end
