class AddProductIdToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchases, :product, null: false, foreign_key: true
    add_reference :purchases, :user, null: false, foreign_key: true
    add_reference :purchases, :supplier, null: false, foreign_key: true
  end
end
