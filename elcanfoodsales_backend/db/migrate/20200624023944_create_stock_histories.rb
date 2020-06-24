class CreateStockHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_histories do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
