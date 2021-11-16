class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.date :date_of_birth
      t.integer :mobile
      t.string :email
      t.string :hashed_password

      t.timestamps
    end
  end
end
