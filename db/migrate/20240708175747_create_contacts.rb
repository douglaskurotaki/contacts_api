# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :cpf
      t.string :phone, null: false

      t.timestamps
    end
  end
end
