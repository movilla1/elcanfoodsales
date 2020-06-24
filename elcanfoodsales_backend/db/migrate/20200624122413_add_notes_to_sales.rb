class AddNotesToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :notes, :string
  end
end
