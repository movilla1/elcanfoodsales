class CreateSaleLines < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_lines do |t|
      t.references :product, null: false, foreign_key: true
      t.float :quantity
      t.float :subtotal
      t.references :sale, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
