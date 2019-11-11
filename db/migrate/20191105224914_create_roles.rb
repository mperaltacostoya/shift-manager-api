# frozen_string_literal: true

# Migration to create roles table in database
class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role_name, default: 'Employee'
      t.belongs_to :user
      t.timestamps
    end
  end
end
