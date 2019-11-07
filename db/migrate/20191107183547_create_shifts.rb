class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.belongs_to :user
      t.text :comments
      t.boolean :open, default: true
      t.timestamps
    end
  end
end
