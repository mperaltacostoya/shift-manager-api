# frozen_string_literal: true

# Migration to create users table in database
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :birthday
      t.string :address
      t.string :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
