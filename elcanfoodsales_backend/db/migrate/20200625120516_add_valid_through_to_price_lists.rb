class AddValidThroughToPriceLists < ActiveRecord::Migration[6.0]
  def change
    add_column :price_lists, :valid_through, :datetime
  end
end
