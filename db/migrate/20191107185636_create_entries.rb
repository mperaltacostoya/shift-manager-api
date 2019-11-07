class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.belongs_to :shift
      t.text :comments
      t.datetime :entry_datetime
      t.timestamps
    end
  end
end
