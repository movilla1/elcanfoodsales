class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.date :birthday
      t.string :phone
      t.string :email
      t.string :pet_name
      t.integer :pet_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
