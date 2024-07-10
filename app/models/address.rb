# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :contact

  validates :city, :street, :number, :zipcode, :uf, :latitude, :longitude, presence: true

  before_validation :set_geolocation

  def set_geolocation
    return unless zipcode_changed?

    geolocation = FindGeolocationUseCase.call(zipcode:)
    return unless geolocation

    self.latitude = geolocation[:latitude]
    self.longitude = geolocation[:longitude]
  end
end
