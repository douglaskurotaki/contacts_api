class AddIndexesToContacts < ActiveRecord::Migration[7.1]
  def change
    add_index :contacts, :name
  end
end
