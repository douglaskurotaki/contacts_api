class AddNotNullAndUniqueIndexToCpfOnContacts < ActiveRecord::Migration[7.1]
  def change
    change_column :contacts, :cpf, :string, null: false
    add_index :contacts, :cpf, unique: true unless index_exists?(:contacts, :cpf, unique: true)
  end
end
