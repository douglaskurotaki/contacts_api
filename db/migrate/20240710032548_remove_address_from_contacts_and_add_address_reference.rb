class RemoveAddressFromContactsAndAddAddressReference < ActiveRecord::Migration[7.1]
  def change
    remove_column :contacts, :address, :string
    remove_column :contacts, :latitude, :float
    remove_column :contacts, :longitude, :float

    add_reference :contacts, :address, null: false, foreign_key: true
  end
end
