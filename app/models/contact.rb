# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  has_one :address
  accepts_nested_attributes_for :address

  validates :name, :cpf, :phone, presence: true
end
