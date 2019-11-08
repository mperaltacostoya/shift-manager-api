class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.belongs_to :user
      t.text :comments, default: ''
      t.datetime :check_in_time
      t.datetime :check_out_time

      t.timestamps
    end
  end
end
