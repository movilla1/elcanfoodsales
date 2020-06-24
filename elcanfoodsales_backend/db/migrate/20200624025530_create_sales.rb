class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :total

      t.timestamps
    end
  end
end
