# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :city, null: false
      t.string :street, null: false
      t.string :uf, null: false
      t.string :neighborhood, null: false
      t.string :zipcode, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :number, null: false
      t.string :complement

      t.timestamps
    end
  end
end
