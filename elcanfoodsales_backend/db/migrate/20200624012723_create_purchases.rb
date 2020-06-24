class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.date :date
      t.float :price
      t.integer :quantity
      t.string :note
      t.integer :status

      t.timestamps
    end
  end
end
