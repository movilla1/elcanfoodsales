class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.date :date_start
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :contact_name
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
