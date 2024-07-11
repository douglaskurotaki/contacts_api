# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  has_one :address
  accepts_nested_attributes_for :address

  validates :name, :cpf, :phone, presence: true

  before_validation :validate_cpf, :validate_phone

  def validate_cpf
    return if cpf.blank?

    normalized_cpf = cpf.gsub(/[^0-9]/, '')
    self.cpf = normalized_cpf
    return if CPF.valid?(normalized_cpf)

    errors.add(:cpf, I18n.t('errors.messages.invalid_format', attribute: 'CPF'))
  end

  def validate_phone
    return if phone.blank?

    normalized_phone = phone.gsub(/[^0-9]/, '')
    self.phone = normalized_phone
    return if normalized_phone.match?(/\A\d{10,11}\z/)

    errors.add(:phone, I18n.t('errors.messages.invalid_format', attribute: 'Telefone'))
  end
end
