# frozen_string_literal: true

# Migration to add role_type column to roles table, using postgres ENUM
class AddRoleTypeToRoles < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE role_role_types AS ENUM ('admin', 'employee');
    SQL
    add_column :roles, :role_type, :role_role_types, default: 'employee'
  end

  def down
    remove_column :roles, :role_type
    execute <<-SQL
      DROP TYPE role_role_types;
    SQL
  end
end
