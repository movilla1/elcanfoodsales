class CreatePriceLists < ActiveRecord::Migration[6.0]
  def change
    create_table :price_lists do |t|
      t.string :name
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
