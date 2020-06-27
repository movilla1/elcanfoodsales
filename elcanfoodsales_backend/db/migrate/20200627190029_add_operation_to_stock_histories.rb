class AddOperationToStockHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_histories, :operation, :integer, default: 0
  end
end
