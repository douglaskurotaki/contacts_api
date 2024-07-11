# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable
  include DeviseTokenAuth::Concerns::User

  has_many :contacts, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }
end
