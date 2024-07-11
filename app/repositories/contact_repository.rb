# frozen_string_literal: true

class ContactRepository
  def self.call(user:, filter_value: nil, order: 'name', page: 1, per_page: 10)
    new(user:, filter_value:, order:, page:, per_page:).call
  end

  def initialize(user:, filter_value: nil, order: nil, page: 1, per_page: 10)
    @user = user
    @filter_value = filter_value
    @order = order
    @page = page
    @per_page = per_page
  end

  def call
    Contact
      .includes(:address)
      .where(user:)
      .where(build_filter_query)
      .order("#{order} ASC")
      .page(page)
      .per(per_page)
  rescue StandardError => e
    Rails.logger.error("[#{self.class}] #{e.message}")
    raise e
  end

  private

  attr_reader :user, :filter_value, :order, :page, :per_page

  def build_filter_query
    return if filter_value.nil?

    value = ActiveRecord::Base.connection.quote_string(filter_value)
    "unaccent(contacts.name) ILIKE unaccent('%#{value}%') OR contacts.cpf ILIKE '%#{value}%'"
  end
end
