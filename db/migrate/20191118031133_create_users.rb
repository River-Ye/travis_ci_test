class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role
      t.string :email
      t.integer :gender
      t.string :tel

      t.timestamps
    end
  end
end
