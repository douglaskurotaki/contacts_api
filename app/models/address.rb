class Address < ApplicationRecord
  has_one :contact

  validates :country, :street, :number, :zipcode, :uf, :latitude, :longitude, presence: true
end
