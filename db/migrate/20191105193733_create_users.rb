class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.datetime :birthday
      t.string :address
      t.string :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
