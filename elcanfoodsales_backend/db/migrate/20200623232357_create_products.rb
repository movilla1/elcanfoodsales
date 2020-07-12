class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :size
      t.float :weight
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
