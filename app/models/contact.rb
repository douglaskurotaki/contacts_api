class Contact < ApplicationRecord
  belongs_to :user

  validates :name, :cpf, :phone, presence: true
end
