class AddEntryTypeToEntry < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE entries_types AS ENUM ('check_in', 'check_out');
    SQL
    add_column :entries, :entry_type, :entries_types, default: 'check_in'
  end

  def down
    remove_column :entries, :entry_type
    execute <<-SQL
      DROP TYPE entries_types;
    SQL
  end
end
