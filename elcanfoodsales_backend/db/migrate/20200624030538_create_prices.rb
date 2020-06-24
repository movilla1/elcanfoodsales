class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :price_list, null: false, foreign_key: true
      t.float :price
      t.integer :status
      t.datetime :valid_until

      t.timestamps
    end
  end
end
